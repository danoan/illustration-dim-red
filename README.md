# Simple illustration of reduction of dimensionality

The goal of this project is to illustrate dimensionality reduction in data analysis. It is a skeleton and it is not generalized. The user should modify the scripts in order to evaluate it for different data.

This simple project creates a plot from insideairbnb.com data for the city of Paris. The quantities observed are Price, Square Feet and Year.  

## Requirements

csvkit
python > 3.0
numpy > 1.16
gnuplot 

## Collecting the data

The scripts in this project were written for a very specific dataset, namely, insideairbnb data for Paris for the months of May from 2015 and 2018. The user can collect the data herself by visiting insideairbnb.com or to execute the script collect.sh.

## Building the figures

The script paris-data-analysis.sh will collect the columns of interest for each year dataset, compute its first two principal components and create a plot with plane fitting and another with no plane fitting.

Usage: sh paris-data-analysis.sh [Paris-Neighborhood]
Example: sh paris-data-analysis.sh Élysée

List of Neighborhoods:

Batignolles-Monceau
Bourse
Buttes-Chaumont
Buttes-Montmartre
Entrepôt
Élysée
Gobelins
Hôtel-de-Ville
Louvre
Luxembourg
Ménilmontant
Observatoire
Opéra
Palais-Bourbon
Panthéon
Passy
Popincourt
Reuilly
Temple
Vaugirard


## Discussion

In this example, the plane could be used to approximate (predict) observations by storing fewer information than the original data (instead of 3n values, we need to store only 2n). The compression ratio becomes more important as we handle data with higher dimensions, the common example being images. A classical application is face recognition.
