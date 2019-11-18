data "external" "spamhaus-edrop" {
    program = ["powershell", "-nologo", "-executionpolicy", "bypass", "-File", "${path.module}/spamhaus-edrop.ps1"]
}