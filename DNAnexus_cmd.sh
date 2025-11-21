#!/usr/bin/bash

module load StdEnvACCRE/2023 python/3.13.2
pip3 install dxpy

dx login # Enter login credentials
dx select project-J3jVPZ0Jf7xYbBP5BKKf6VfF

module load java/11.0.22
wget https://github.com/dnanexus/dxCompiler/releases/download/2.15.0/dxCompiler-2.15.0.jar

java -jar dxCompiler-2.15.0.jar compile liftover_plink_beds.wdl
# workflow-J4QKVJ0Jf7xyYfyZg837BjFY

wget -nd biobank.ndph.ox.ac.uk/ukb/ukb/auxdata/1000genomes.grch38.fasta-index.tar.gz
wget https://raw.githubusercontent.com/broadinstitute/gatk/master/scripts/funcotator/data_sources/gnomAD/b37ToHg38.over.chain

dx upload --path '/PheWAS/Data/b37ToHg38.over.chain' b37ToHg38.over.chain
dx upload --path '/PheWAS/Data/1000genomes.grch38.fasta-index.tar.gz' 1000genomes.grch38.fasta-index.tar.gz

dx run workflow-J4QKVJ0Jf7xyYfyZg837BjFY
# stage-common.plink_beds[0]: Bulk/Genotype\ Results/Genotype\ calls/ukb22418_c21_b0_v2.bed
# stage-common.plink_bims[0]: Bulk/Genotype\ Results/Genotype\ calls/ukb22418_c21_b0_v2.bim
# stage-common.plink_fams[0]: Bulk/Genotype\ Results/Genotype\ calls/ukb22418_c21_b0_v2.fam
# stage-common.reference_fastagz: PheWAS/Data/1000genomes.grch38.fasta-index.tar.gz
# stage-common.ucsc_chain: PheWAS/Data/b37ToHg38.over.chain

# Analysis ID: analysis-J4QKvY8Jf7xY6pxPj7GZXKX8

# Alternatively, use a JSON input and run the command below:
# dx run workflow-J4QKVJ0Jf7xyYfyZg837BjFY -f liftover_input.json --brief -y

dx logout
