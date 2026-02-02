# Molecular Data Analysis and Bioinformatics (MDA)

This repository contains materials for the Molecular Data Analysis module for the master Biological Sciences (University of Amsterdam). It is organized in a Quarto website.

## Structure

```
.
├── docs/
│   ├── ... # will contain all rendered website materials
├── _quarto.yml     # Main quarto settings      
├── index.qmd       # Main landing page     
├── styles.css           
├── setup/
│   ├── index.qmd       
│   └── *.qmd            
├── part1-dataviz/
│   ├── index.qmd        
│   └── *.qmd            
├── part2-rna-seq/
│   ├── index.qmd        
│   └── *.qmd            
└── part3-genome-assembly/
    ├── index.qmd        
    └── *.qmd            
```

## How to Use

### Adding Episodes

Simply add `.qmd` files to any of the section folders:
- `setup/` for Setup episodes
- `part1-dataviz/` for Data Viz episodes
- `part2-rna-seq/` for RNA-seq episodes
- `part3-genome-assembly/` for Genome Assembly episodes

The sidebar will automatically populate with all `.qmd` files in each folder (except `index.qmd`).

