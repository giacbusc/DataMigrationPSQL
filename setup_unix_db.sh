#!/bin/bash

# Parametri del database
DB_NAME="cinemamartin"
DB_USER="martin"
DB_PASSWORD="gabbia"

# Comandi SQL per creare l'utente
SQL_CREATE_USER=$(cat <<EOF
DO \$\$
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '$DB_USER') THEN
      CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
   END IF;
END
\$\$;
EOF
)

# Comandi SQL per creare il database e assegnare privilegi
SQL_GRANT_PRIVILEGES=$(cat <<EOF
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
GRANT ALL PRIVILEGES ON SCHEMA public TO $DB_USER;
EOF
)

# Esegui i comandi SQL per creare l'utente
psql -U postgres -c "$SQL_CREATE_USER"

# Crea il database
psql -U postgres -c "CREATE DATABASE $DB_NAME;"

# Assegna privilegi
psql -U postgres -d $DB_NAME -c "$SQL_GRANT_PRIVILEGES"
