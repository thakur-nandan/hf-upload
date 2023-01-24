for dataset in signal1m nq
do
    export DATASET=${dataset}-top-20-gen-queries
    export ORG=income
    export PATH_TO_FOLDER=/store2/scratch/n3thakur/hf-upload 
    
    # 1. Using HF CLI create the repo. It will prompt [Y/N] => Y.
    huggingface-cli repo create ${DATASET} --type dataset --organization ${ORG}
    
    # 2. From your current directory, clone the repository.
    cd ${PATH_TO_FOLDER}
    git lfs install
    git clone https://huggingface.co/datasets/${ORG}/${DATASET}
    
    # 3. Copy the README.md file.
    cp Documentation.md ${DATASET}/README.md

    # 4. Go the path where top-20 generation file is present and gunzip.
    cd /store2/scratch/n3thakur/beir-datasets/${dataset}
    gzip -k top20-gen-queries.jsonl  # (-k) keeps the original jsonl file.
    
    # 5. Move the top-20-gen-queries.jsonl.gz, and rename as train.jsonl.gz
    mv top20-gen-queries.jsonl.gz ${PATH_TO_FOLDER}/${DATASET}/train.jsonl.gz
    cd ${PATH_TO_FOLDER}/${DATASET}/

    # 6. Git add/commit and push the files.
    git add .
    git commit -m "initial file add and README."
    git push
done