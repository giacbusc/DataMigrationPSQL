# local_service/local_service/data_migration/models.py
from django.db import models

class Sala(models.Model):
    numero = models.IntegerField(primary_key=True)
    numPosti = models.IntegerField()
    dim = models.FloatField()
    numFile = models.IntegerField()
    numPostiPerFila = models.IntegerField()
    tipo = models.CharField(max_length=20)

class Proiezione(models.Model):
    numProiezione = models.IntegerField(primary_key=True)
    sala = models.ForeignKey(Sala, on_delete=models.CASCADE)
    film_proiettato = models.IntegerField()
    data = models.DateField()
    ora = models.TimeField()

class Biglietto(models.Model):
    numProiezione = models.ForeignKey(Proiezione, db_column='numProiezione', on_delete=models.CASCADE)
    numFila = models.IntegerField()
    numPosto = models.IntegerField()
    dataVendita = models.DateField()
    prezzo = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
        unique_together = (('numProiezione', 'numFila', 'numPosto'),)
        db_table = 'data_migration_biglietto'


class Film(models.Model):
    codice = models.IntegerField(primary_key=True)
    titolo = models.CharField(max_length=100)
    anno = models.IntegerField()
    durata = models.IntegerField()
    lingua = models.CharField(max_length=50)
