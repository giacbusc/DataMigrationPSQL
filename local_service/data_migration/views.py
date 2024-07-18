# local_service/local_service/data_migration/views.py
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import Sala, Proiezione, Biglietto, Film

@csrf_exempt
def insert_data(request, model):
    if request.method == 'POST':
        data = json.loads(request.body)
        try:
            for item in data:
                if model == 'data_migration_sala':
                    Sala.objects.create(
                        numero=item['numero'],
                        numPosti=item['numPosti'],
                        dim=item['dim'],
                        numFile=item['numFile'],
                        numPostiPerFila=item['numPostiPerFila'],
                        tipo=item['tipo']
                    )
                elif model == 'data_migration_proiezione':
                    sala = Sala.objects.get(numero=item['sala'])  # Assicurati che la sala esista
                    Proiezione.objects.create(
                        numProiezione=item['numProiezione'],
                        film_proiettato=item['film_proiettato'],
                        data=item['data'],
                        ora=item['ora'],
                        sala_id=sala.numero  # Utilizza sala_id
                    )
                elif model == 'data_migration_film':
                    Film.objects.create(
                        codice=item['codice'],
                        titolo=item['titolo'],
                        anno=item['anno'],
                        durata=item['durata'],
                        lingua=item['lingua']
                    )
                elif model == 'data_migration_biglietto':
                    proiezione = Proiezione.objects.get(numProiezione=item['numProiezione'])  #Assicurati che la proiezione esista
                    Biglietto.objects.create(
                        numProiezione_id=proiezione.numProiezione,  # Utilizza numProiezione_id
                        numFila=item['numFila'],
                        numPosto=item['numPosto'],
                        dataVendita=item['dataVendita'],
                        prezzo=item['prezzo']
                    )
            return JsonResponse({'status': 'success'})
        except Exception as e:
            return JsonResponse({'status': 'fail', 'message': str(e)})
    return JsonResponse({'status': 'fail', 'message': 'Invalid request method'})
