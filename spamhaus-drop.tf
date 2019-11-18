data "external" "spamhaus-drop" {
    program = ["powershell", "-nologo", "-executionpolicy", "bypass", "-File", "${path.module}/spamhaus-drop.ps1"]
}