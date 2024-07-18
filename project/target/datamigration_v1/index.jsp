<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Progetto di Migrazione Dati</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .hero {
            background-color: #007bff;
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .hero h1 {
            font-size: 4rem;
        }
        .hero p {
            font-size: 1.5rem;
        }
        .feature {
            padding: 20px;
            border-radius: 5px;
            background: #f9f9f9;
            margin-bottom: 20px;
            text-align: center;
        }
        .authors {
            margin-top: 50px;
        }
        .authors h2 {
            font-size: 2rem;
            margin-bottom: 20px;
        }
        .authors p {
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="hero">
            <h1>Progetto di Migrazione Dati</h1>
            <p>Migra facilmente i tuoi dati da MySQL a PostgreSQL</p>
            <a href="migrate" class="btn btn-primary btn-lg">Avvia la Migrazione dei Dati</a>
        </div>

        <div class="row my-5">
            <div class="col-md-4">
                <div class="feature">
                    <h3 class="mt-3">Migrazione Senza Problemi</h3>
                    <p>Vivi un processo di migrazione fluido e senza errori con i nostri strumenti all'avanguardia.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature">
                    <h3 class="mt-3">Trasferimento Dati Sicuro</h3>
                    <p>Diamo priorità alla sicurezza per garantire che i tuoi dati siano al sicuro durante il processo di migrazione.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature">
                    <h3 class="mt-3">Supporto Completo</h3>
                    <p>Il nostro team di supporto è qui per assisterti in ogni fase del percorso di migrazione.</p>
                </div>
            </div>
        </div>

        <div class="text-center my-5">
            <h2>Informazioni sul Nostro Progetto</h2>
            <p class="lead">Questo progetto mira a fornire un modo affidabile ed efficiente per migrare i dati da MySQL a PostgreSQL. 
                I nostri strumenti sono progettati per ridurre al minimo i tempi di inattività e garantire l'integrità dei dati durante tutto il processo di migrazione.</p>
        </div>

        <div class="text-center authors my-5">
            <h2>Autori del Progetto</h2>
            <p>Giacomo Buscaglia, 1078804</p>
            <p>Giulia Signori, 1078801</p>
            <p>Marco Zanda, 1080427</p>
        </div>

        <footer class="text-center mt-5">
            <p>&copy; 2024 Data migration project. Università degli studi di Bergamo. Tutti diritti sono riservati</p>
        </footer>
    </div>
</body>
</html>
