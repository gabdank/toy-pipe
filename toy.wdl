workflow toy {
    # inputs
    Array[File] fastqs
    Int min_length

    call trim {
        input: fastqs=fastqs,
            min_length=min_length
    }

    output {
        Array[File] output = trim.files
    }
}

task trim {
    Array[File] fastqs
    Int min_length
    
    command {
        java -jar /Trimmomatic-0.38/trimmomatic-0.38.jar PE -phred33 ${fastqs[0]} ${fastqs[1]} out1.fastq.gz out1.unpaired.fastq.gz out2.fastq.gz out2.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:30 MINLEN:${min_length}
    }

    output{
        Array[File] files = glob('*.fastq.gz')
    }

    runtime {
        docker: "quay.io/gabdank/toy:v2"
    }
}