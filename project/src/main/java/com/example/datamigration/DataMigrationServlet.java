package com.example.datamigration;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Logger;

import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//la classe della servlet
public class DataMigrationServlet extends HttpServlet {
    //oggetto per il display dell'esecuzione
    private static final Logger logger = Logger.getLogger(DataMigrationServlet.class.getName());

    //funzione invocata da una richiesta di tipo GET alla servlet, che gestisce la migrazione dei dati e crea un html contenente informazioni di debug
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html");
        String[] tables = {"Sala", "Proiezione", "Biglietto", "Film"};
        try {
            //creazione del file html contenente la risposta alla richiesta 
            response.getWriter().write("<html><head><title>Data Migration</title>");
            response.getWriter().write("<link href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\" rel=\"stylesheet\">");
            response.getWriter().write("<style>body { padding: 20px; }</style>");
            response.getWriter().write("</head><body>");
            response.getWriter().write("<div class='container'>");
            response.getWriter().write("<h1 class='text-center'>Data Migration</h1>");
            response.getWriter().write("<div class='progress mb-3'><div class='progress-bar' role='progressbar' style='width: 0%;' id='progress-bar'></div></div>");
            response.getWriter().write("<ul class='list-group'>");

            int tableCount = tables.length;
            int currentTable = 0;

            //qui viene mostrato se la migrazione dei dati sta avvenendo
            for (String table : tables) {
                currentTable++;
                int progressPercentage = (currentTable * 100) / tableCount;

                response.getWriter().write("<li class='list-group-item'>");
                response.getWriter().write("<strong>Migrating table: " + table + "</strong>");
                response.getWriter().write("<div class='spinner-border spinner-border-sm ml-2' role='status' id='spinner-" + table + "'></div>");
                response.getWriter().write("</li>");
                logger.info("Starting migration for table: " + table);

                //esecuizone della migrazione dei dati
                migrateTableData(table, response);

                logger.info("Completed migration for table: " + table);

                response.getWriter().write("<script>document.getElementById('spinner-" + table + "').classList.remove('spinner-border');</script>");
                response.getWriter().write("<script>document.getElementById('progress-bar').style.width = '" + progressPercentage + "%';</script>");
            }

            //qui viene mostrato se la migrazione dei dati è avvenuta con successo
            response.getWriter().write("</ul>");
            response.getWriter().write("<div class='alert alert-success mt-3' role='alert'>Data migration completed successfully!</div>");
            response.getWriter().write("</div></body></html>");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //funzione che gestisce la migrazione dei dati dal database in Altervista al database in Postgres, servendosi di un server in Django
    private void migrateTableData(String table, HttpServletResponse response) {
        try {
            //estrazione dei dati dalla tabella desiderata nel database in Altervista tramite l'invocazione di uno script php posto nel filesystem di Altervista
            //a cui viene passato, con il metodo GET, l'attributo tabella
            URL remoteUrl = new URL("http://zanda5ie.altervista.org/remote_webservice.php?tabella=" + table);
            HttpURLConnection remoteConnection = (HttpURLConnection) remoteUrl.openConnection();
            remoteConnection.setRequestMethod("GET");

            //lettura dei dati
            BufferedReader in = new BufferedReader(new InputStreamReader(remoteConnection.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            remoteConnection.disconnect();

            //comunicazione della corretta lettura dei dati
            logger.info("Received data for table " + table + ": " + content.length() + " characters");

            //collegamento con il protocollo HTTP1 al server di Django, a cui vengono comunicati i dati della tabella tramite il metodo POST in formato JSON
            //il server si occupera dell'inserimento dei dati nel database di Postgres
            URL localUrl = new URL("http://127.0.0.1:8000/data/insert-data/data_migration_" + table.toLowerCase() + "/");
            HttpURLConnection localConnection = (HttpURLConnection) localUrl.openConnection();
            localConnection.setRequestMethod("POST");
            localConnection.setRequestProperty("Content-Type", "application/json");
            localConnection.setDoOutput(true);

            try (OutputStream os = localConnection.getOutputStream()) {
                byte[] input = content.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            //comunicazione del corretto invio dei dati
            int localResponseCode = localConnection.getResponseCode();
            response.getWriter().write("<script>document.querySelector('li:contains(\"" + table + "\")').innerHTML += ' - Status: " + localResponseCode + "';</script>");
            logger.info("Migration status for table " + table + ": " + localResponseCode);

        } catch (Exception e) {
            //gestione di eventuali eccezioni
            e.printStackTrace();
            try {
                response.getWriter().write("<script>document.querySelector('li:contains(\"" + table + "\")').innerHTML += ' - Error: " + e.getMessage() + "';</script>");
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
