scp -i ~/.ssh/rdf_virginia_ec2_key_pair.pem -r data/* ec2-user@ec2-54-89-118-252.compute-1.amazonaws.com:docker-go-edb-api/data

# build in dev image
docker build --tag rust-edb-api:multistage .

