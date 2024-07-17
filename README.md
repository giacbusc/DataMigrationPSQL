# DataMigrationPSQL
Servizio di migrazione dati da un database MySQL gestito tramite phpmyadmin verso un database PostgreSQL gestito tramite pgAdmin

## Prerequisiti
E' necessario avere installato sulla propria macchina
- PostgreSQL (version **16.x**)
- Django (version **5.x+**)
- Python (version **3.x+**)
- Tomcat (version **9.x+**)

Opzionale (ma fortemente consigliato)
- VScode (version **1.8x**)

Si noti che le versioni indicate sono quelle testate per cui l'applicativo lavora correttamente. 
Non sono stati svolti test con altre versioni. In caso di problematiche con qualche versione specifica si prega di aprire un issue e segnalare il problema


## Guida all'installazione e all'esecuzione del progetto

### 1) Creazione del database PostgreSQL
#### Per sistema operativo Windows:
Nella repository si trova il file `setup_win_db.ps1`. <br>
Aprire come **amministratore** la PowerShell di windows nella stessa directory dove è stato installato il file `.ps1`.
Fatto questo eseguire il comando
```
.\setup_windows_db.ps1
```
Verrà richiesto poi di inserire la password (creata in fase di installazione di postgresql) dell'utente di default `postgres` (nel nostro caso `admin`)

#### Per sistema operativo Unix-like:
Nella repository si trova il file `setup_unix_db.sh`.
Aprire il terminale nella stessa directory di dove è stato installato il file `.sh`.
Fatto questo eseguire i seguenti comandi
```
chmod +x setup_unix_db.sh
```
```
./setup_unix_db.sh
```
Verrà richiesto poi di inserire la password (creata in fase di installazione di postgresql) dell'utente di default `postgres` (nel nostro caso `admin`)

<br><br>

Se dovessero esserci problemi questo è dovuto alla mancanza di postgreSQL nel sistema per eseguire comandi da linea di comando, verificare quindi la corretta installazione lanciando il comando `psql --version`. <br>
Se questo non è presente si rimanda ad una [guida esterna](https://sqlbackupandftp.com/blog/setting-windows-path-for-postgres-tools/) per il corretto proseguimento nell'installazione<br>
(Si noti che è possibile anche procedere alla creazione manuale del database ma per rendere il tutto più automatizzato è stato creato questo script in modo da ovviare a svariati problemi)

### 2) Scaricare il file local_service.zip
Django viene utilizzato per 
- la creazione delle tabelle in modo automatico su postgreSQL
- il caricamento dei dati su postgreSQL tramite una richiesta della servlet

#### 2.1) Creazione delle tabelle 
Per procedere alla creazione delle tabelle utili ai fini di una corretta migrazione dei dati scaricare il file `local_service.zip` presente nella repository.
Procedere quindi ad estrarre il `.zip`. Avviare quindi il terminale come **amministratore** nella cartella `local_service`.<br>
Eseguire quindi i comandi nel seguente ordine:

```
python3 manage.py makemigrations data_migration
```
```
python3 manage.py migrate data_migration
```
Se la <ins>versione di python è inferiore alla 3.0</ins> lanciare i seguenti comandi invece:

```
python manage.py makemigrations data_migration
```
```
python manage.py migrate data_migration
```

I problemi che si possono verificare in questa fase possono derivare dall'assenza di python3 (o python) come comando riconosciuto dal terminale.
Si chiede quindi di verificare l'installazione seguendo questa [guida esterna](https://phoenixnap.com/kb/how-to-install-python-3-windows)<br>
Se python risulta già installato sulla macchina ma comunque i comandi non vengono riconosciuti seguire la guida esterna qui sopra dal *punto 4)* in avanti.

#### 2.2) Avvio server django
Per avviare quindi il server django che procederà a caricare i dati su postgreSQL eseguire su terminale (sempre nella directory /local_service)
```
python3 manage.py runserver
```
Questo comando avvia un server django all'indirizzo `http://127.0.0.1:8000` (indirizzo di default, esso non è stato modificato nelle impostazioni pertanto se si è deciso di modificarlo in fase di installazione di django è bene fare attenzione e riportarlo alle impostazioni di default) <br>
Si noti che è stata la <ins>versione 5.x di Django</ins>. Versioni precedenti non sono state testate
Se il server non viene avviato correttamente controllare verificare che django sia correttamente installato.<br>
_Avviato il server proseguire quindi al punto 3_

### 3) Esecuzione della servlet

#### 3.1) Avvio di tomcat

#### Metodo consigliato (per evitare problemi con versioni di tomcat)
Se si ha già installato vscode sulla propria macchina si consiglia di utilizzare l'estensione **_"Community Server Connector"_**. 
Si consiglia di seguire il video qui sotto per una corretta installazione e esecuzione del progetto.<br>

https://github.com/user-attachments/assets/1278ce0c-2c5f-427c-801a-cca396b62c06

Il file visualizzato nel video si chiama `simple.war`, nel nostro caso il file si chiama `datamigration_v1.war`. 
Si consiglia di utilizzare la versione `apache-tomcat-9.0.30` in quanto è quella con cui il progetto è stato testato. <br>
Fatto questo è possibile visualizzare la homepage del progetto di migrazione dati tramite il seguente link [http://localhost:8080/datamigration1.0/](http://localhost:8080/datamigration-1.0-SNAPSHOT/)

#### Per sistema operativo Windows:
Aprire il terminale nella directory `bin` dei file di installazione di tomcat ed eseguire il comando 
```
./startup.bat
```
Caricare il file `datamigration_v1.war` che si trova all'interno della repository nella cartella webapp. <br>
**IL FILE NON DEVE ESSERE ESTRATTO**, tomcat penserà a tutto in maniera automatica<br>
Fatto questo è possibile visualizzare la homepage del progetto di migrazione dati tramite il seguente link [http://localhost:8080/datamigration1.0/](http://localhost:8080/datamigration-1.0-SNAPSHOT/)

#### Per sistema operativo Unix-like:
Aprire il terminale nella directory `bin` dei file di installazione di tomcat ed eseguire il comando 
```
./startup.sh
```
Caricare quindi il file `datamigration_v1.war` che si trova all'interno della repository nella cartella webapp. <br>
**IL FILE NON DEVE ESSERE ESTRATTO**, tomcat penserà a tutto in maniera automatica<br>
Fatto questo è possibile visualizzare la homepage del progetto di migrazione dati tramite il seguente link [http://localhost:8080/datamigration1.0/](http://localhost:8080/datamigration-1.0-SNAPSHOT/)

### 4) Inizio migrazione dati
Aperto il browser cliccare quindi `Avvia la Migrazione dei Dati` e attendere il caricamento della pagina che fornirà il riscontro dell'operazione.





