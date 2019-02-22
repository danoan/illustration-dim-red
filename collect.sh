echo "Cleaning old data..."
rm -rf data
mkdir -p data


echo "Downloading data for Paris May 2015..."
wget http://data.insideairbnb.com/france/ile-de-france/paris/2015-05-06/data/listings.csv.gz -O data/paris-may-2015.csv.gz && gzip -d data/paris-may-2015.csv.gz

echo "Downloading data for Paris May 2016..."
wget http://data.insideairbnb.com/france/ile-de-france/paris/2016-05-02/data/listings.csv.gz -O data/paris-may-2016.csv.gz && gzip -d data/paris-may-2016.csv.gz


echo "Downloading data for Paris May 2017..."
wget http://data.insideairbnb.com/france/ile-de-france/paris/2017-05-05/data/listings.csv.gz -O data/paris-may-2017.csv.gz && gzip -d data/paris-may-2017.csv.gz


echo "Downloading data for Paris May 2018..."
wget http://data.insideairbnb.com/france/ile-de-france/paris/2018-05-11/data/listings.csv.gz -O data/paris-may-2018.csv.gz && gzip -d data/paris-may-2018.csv.gz

echo "Done!"
