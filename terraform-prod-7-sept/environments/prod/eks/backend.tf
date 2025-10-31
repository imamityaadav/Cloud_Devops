terraform {
  backend "s3" {
    bucket     = "gyan-bharatam-terrafrom-backend-bucket-prod"
    key        = "prod/backend/eks"
    region     = "ap-south-1" 
    #use_lockfile = true  #S3 native locking
    
  #  assume_role = {
  #  role_arn = ""
  #  session_name = "terraform-session"
  #}
  }
}