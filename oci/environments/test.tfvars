environment = "Calidad"

project_name = "IA"

vcn_cidr = "10.0.0.0/16"

subnet_cidr = "10.0.1.0/24"

instances = {
  servidor_principal = {
    image_id      = "ocid1.image.oc1.phx.aaaaaaaa7vfcxlrhixvjz457yvgs22f3676uzw7rdodw7w4jptmgorzroqda"
    shape         = "VM.Standard.E5.Flex"
    ocpus         = 2
    memory_in_gbs = 4
  }
}

compartment_ocid = "ocid1.compartment.oc1..aaaaaaaacmh54mncufimtib2vkzhvabdtubrr67mc7kmmbf4rxha62pbu4ua"
