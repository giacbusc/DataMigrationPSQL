# Parametri del database
$DB_NAME = "cinemamartin"
$DB_USER = "martin"
$DB_PASSWORD = "gabbia"

# Comandi SQL per creare l'utente
$sqlCreateUser = @"
CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
"@

# Comandi SQL per assegnare privilegi
$sqlGrantPrivileges = @"
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
GRANT ALL PRIVILEGES ON SCHEMA public TO $DB_USER;
"@

# Esegui i comandi SQL per creare l'utente solo se non esiste
if (-not (psql -U postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'")) {
    psql -U postgres -c "$sqlCreateUser"
}

# Crea il database solo se non esiste
if (-not (psql -U postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")) {
    psql -U postgres -c "CREATE DATABASE $DB_NAME;"
}

# Assegna privilegi
psql -U postgres -d $DB_NAME -c "$sqlGrantPrivileges"
