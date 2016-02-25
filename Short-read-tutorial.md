This practical is about visualizing FASTQ quality, running R scripts thrugh the command line and automating execution with make.

### Preliminaries

* Log into blnx!@emory.edu thrugh ssh

* Create a new flder in your home area and clone the github repo containing the class

* In a different window, log onto the Rstudio server on blnx1 thrugh a web browser [](http://blnx1.emory.edu:8787)

### Look at the files _SR-qualplot.R_ and _shortread_tutorial.Rmd_  through Rstudio

This file creates a plot of the quality scres for each cycle in the FASTQ file at the path "/home/Shared/IBS574/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq".  We will go through this step-by-step to understand how the script works.

### Run scriptshortread_tutorial.Rmd 

Open the plot "q-graph.pdf" using the RStudio Files section.

Make sure you understand what the plot is showing.  Is this a high quality FASTQ file? 

### Run the same FASTQ file thrugh SR-qualplot.R in the command line

(SR-qualplot.R is essentially the same pipeline as scriptshortread_tutorial.Rmd but takes arguments on the command line)

First, make a new folder to store the utput of the analysis and cd into it.

Now look at the folder /home/Shared/IBS574/MiSeq_SOP/.  You can see it contains a bunch of fastq files (as well as some ther files we are nt interested in).

To run the Rscript as before type

    Rscript --vanilla PATH/SR-qualplot.R /home/Shared/IBS574/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq

Where "_PATH_/" is the unix path to the SR-qualplot.R file.

Make sure you understand what just happened!

### Automate a pipeline with _make_

Create a file call _Makefile_ in your working directry. ( You can use emacs or the RStudio new_file>text dialog).

In the Makefile insert the text as below

    F3D0_S188_L001_R1_001.pdf: /home/Shared/IBS574/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq
        Rscript --vanilla ./SR-qualplot.R /home/Shared/IBS574/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq
        mv q-graph.pdf F3D0_S188_L001_R1_001.pdf
        
It is important that the second and third line start with tabs.

On the first line of the  Makefile is defining the creation of the target file "F3D0_S188_L001_R1_001.pdf".  The file on the right of the colon, "/home/Shared/IBS574/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq" is called a prerequisite.  This file is needed fr the formula.

To get a preview of using make type

    make --just-print
    
You should see,

    Rscript --vanilla ./SR-qualplot.R /home/Shared/IBS574/MiSeq_SOP/F3D0_S188_L001_R1_001.fastq
    mv q-graph.pdf F3D0_S188_L001_R1_001.pdf
    
If so, running the command make will execute the commands.  Why do you NOT see "q-graph.pdf"?

Type in "make --just-print" again.  What do you see and why?

Now remove the file F3D0_S188_L001_R1_001.pdf

    rm F3D0_S188_L001_R1_001.pdf
    
What happens when you preview with "make --just-print"?

### Exercise:  Create a second make rule for the reverse read "F3D0_S188_L001_R2_001.fastq"

You will need to create a new master rule called 'all' at the top to run your other rules

    all: F3D0_S188_L001_R1_001.pdf F3D0_S188_L001_R2_001.pdf

Execute your pipeline using make.

How does the quality of the reverse read look?

### Homework:  Look at the GNU make blogs and tutorals and find an elegant way to run *all* the FASTQ files in the MiSeq_SP folder (or indeed any FASTQ files in a given folder).

This could be achieved in one of two ways.  

* Modify the _SR-qualplot.R_ script to create a loop inside.  Yu will need to look at the _list.files_ function and be careful that you only run FASTQ files.  Yu also need to think about giving different names to every file that is outputted.

* (Harder, but shorter). Mdify the Makefile using make wildcards.  You will need t chekc the make manual or online blgs and tutorials.

Due next wednesday.
