# Inleiding

In dit demo-project concentreren we ons op de stappen voor *data preparation* aan de hand van de Formule 1-data zoals de [Fast F1-API](https://docs.fastf1.dev/) levert. We volgen daarbij een aantal stappen van de CRISP-DM-cyclus, maar niet alle stappen komen even uitgebreid aan de orde. Waar mogelijk worden de keuzes en realisatie ervan zo goed mogelijk uitgelegd.

Belangrijkste doel is om te laten zien hoe je een project als dit kunt aanpakken en hoe je producten kunt ontwikkelen die resultaten leveren die je ook in een andere omgeving (andere pc of server van een opdrachtgever) kunt reproduceren.

Om ermee aan de slag te gaan, kun je het beste deze repository clonen op je eigen machine, de software installeren en de notebooks in het mapje `notebooks` openen. 

In een demo kan niet alles aan de orde komen. In het laatste deel van de tekst wordt een aantal aspecten opgesomd die niet aan de orde komen, maar die wel relevant (kunnen) zijn voor een analytics-project.

Hogeschool Utrecht, november 2023

Jan-Willem Lankhaar

# Repo clonen

Om met deze repository te werken is het volgende vereist:

- Python 3.11 of hoger
- VSCode of PyCharm
- git (met `git` in je `PATH`-environment variabele)
- PostgreSQL (met `psql` in je `PATH`-environment variabele)
- Power BI

Maak (bv. met Windows Verkenner) een map aan op je harde schijf (bv. `se3demo`). Dit is je **projectmap**.

Ga naar je projectmap en open een PowerShell-terminal (rechtsklikken in Windows Verkenner). Clone de repository met het volgende commando (let op de punt aan het eind!):

```powershell
git clone https://github.com/jwlankhaar-hu/etldemo.git .
```


Als alles goed gaat, heb je na een paar seconden een kopie van de projectbestanden in je projectmap.

# Python-omgeving installeren met `venv`

1. Python virtual environment aanmaken:
   1. Ga naar je projectmap
   2. Open een PowerShell-terminal en maak een virtual environment aan met:
   ```powershell
   python -m venv .venv --upgrade-deps
   ```
2. Virtual environment activeren:
   ```powershell
   .venv\Scripts\Activate.ps1
   ```
   (Waarschijnlijk krijg je de eerste keer een foutmelding over het uitvoeren van PowerShell-scripts. Zie [hier](https://pureinfotech.com/change-execution-policy-run-scripts-powershell/) voor hoe je dat kunt oplossen. De makkelijkste (maar niet de veiligste) optie is om de `ExecutionPolicy` op `Unrestricted` te zetten.)
3. Benodigde packages installeren met:
   
   ```powershell
   pip install -r requirements.txt
   ```

De volgende packages worden dan geïnstalleerd:
- `ruff`: linter en code formatter (handig bij het programmeren)
- `pandas`: werken met 'dataframes' (tabellen) in Python
- `fastf1`: Fast F1 API
- `matplotlib`: datavisualisatie
- `jupyterlab`: Jupyter Notebooks
- `requests`: uitvoeren van web requests


## Aan de slag

Open in VSCode of PyCharm het notebook `notebooks\01 Business Understanding.ipynb`.

Let op! Om de code in een Jupyter notebook te kunnen uitvoeren moet je een *kernel* selecteren. (In VSCode is dat de knop `Select kernel` rechtsboven.) Let er daarbij op dat je de kernel van je virtual environment kiest (`.venv\Scripts\python.exe`).


