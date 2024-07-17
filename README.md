# DataMigrationPSQL
Servizio di migrazione dati da un database MySQL gestito tramite phpmyadmin verso un database PostgreSQL gestito tramite pgAdmin

## Prerequisiti
E' necessario avere installato sulla propria macchina
- PostgreSQL (version 16)
- Django (version 5.0+)
- Python (version 3.0+)
- Tomcat (version 9.0+)
- VScode (version 1.87)

Si noti che le versioni indicate sono quelle testate per cui l'applicativo lavora correttamente. 
Non sono stati svolti test con altre versioni. In caso di problematiche con qualche versione specifica si prega di aprire un issue e segnalare il problema


## Guida all'installazione

### 1) Creazione del database PostgreSQL
#### Per sistema operativo Windows:
Nella repository si trova il file `setup_win_db.ps1`. <br>
Aprire come **amministratore** la PowerShell di windows nella stessa directory dove è stato installato il file `.ps1`.
Fatto questo eseguire il comando `.\setup_windows_db.ps1`.<br>
Verrà richiesto poi di inserire la password (creata in fase di installazione di postgresql) dell'utente di default `postgres` (nel nostro caso `admin`)

#### Per sistema operativo Unix-like:
Nella repository si trova il file `setup_unix_db.sh`.
Aprire il terminale nella stessa directory di dove è stato installato il file `.sh`.
Fatto questo eseguire il comando `chmod +x setup_unix_db.sh` e dopodiche eseguire `./setup_unix_db.sh`.<br>


Se dovessero esserci problemi questo è dovuto alla mancanza di postgreSQL nel sistema per eseguire comandi da linea di comando, verificare quindi la corretta installazione lanciando il comando `psql --version`. <br>
Se questo non è presente si rimanda ad una [guida esterna](https://sqlbackupandftp.com/blog/setting-windows-path-for-postgres-tools/) per il corretto proseguimento nell'installazione<br>
(Si noti che è possibile anche procedere alla creazione manuale del database ma per rendere il tutto più automatizzato è stato creato questo script in modo da ovviare a svariati problemi)


