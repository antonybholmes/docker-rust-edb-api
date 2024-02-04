git clone git@github.com:antonybholmes/rust-edb-api.git
git clone git@github.com:antonybholmes/rust-dna.git
git clone git@github.com:antonybholmes/rust-loctogene.git

pwd=`pwd`
for d in `find . -maxdepth 1 -type d`
do
	cd ${d}
	git pull
	cd ${pwd}
done
