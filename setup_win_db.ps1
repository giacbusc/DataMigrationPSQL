# Parametri del database
$DB_NAME = "cinemamartin"
$DB_USER = "martin"
$DB_PASSWORD = "gabbia"

# Comandi SQL per creare l'utente
$sqlCreateUser = @"
DO \$\$
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '$DB_USER') THEN
      CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
   END IF;
END
\$\$;
"@

# Comandi SQL per assegnare privilegi
$sqlGrantPrivileges = @"
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
GRANT ALL PRIVILEGES ON SCHEMA public TO $DB_USER;
"@

# Esegui i comandi SQL per creare l'utente
psql -U postgres -c "$sqlCreateUser"

# Crea il database
psql -U postgres -c "CREATE DATABASE $DB_NAME;"

# Assegna privilegi
psql -U postgres -d $DB_NAME -c "$sqlGrantPrivileges"
