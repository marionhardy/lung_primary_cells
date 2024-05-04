# Primary lung cells and SPREADs: RNAseq analysis of cytokine and pitavastatin treatment
## Introduction
This is a collaboration with Amir Zeki and Kenneth Chmiel from Pulmonary, Critical Care and Sleep Medicine at the UCD med center.
Kenneth did RNAseq on lung primary cells treated with
- Control
- Pitavastatin
- Cytokines (IL4, IL5, IL13) -> to be verified
- Pitavastatin + Cytokines

That data was aligned by the genome center, we have the preliminary reports.

Motivation for this study: We want to know what pathways/processes changed after different treatments. We are specifically interested in seeing why cytokines (IL5, IL13, ILxx) induce SPREADS but do not when coupled with pitavastatin.
So, ultimately, what is pitavastatin suppressing?

## Content of this repository

- DESeq2.R
- qc_report_genome_center.html: quality control of the alignment of the data
- initial_report_genome_center: describes each sample (used for annotations) and did a basic PCA + how many genes are differentially expressed when comparing conditions.
- Primary_cell_report1.Rmd + .html








