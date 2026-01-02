module "dev_infrastructure_template"{
  source = "./infrastructure" 
  env = "dev"
  bucket_name = "infrastructure-bucket"
  hash-key = "student_id"
  instance_type = "t3.micro"
  instance_count = 1
  
}
