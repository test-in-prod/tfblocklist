data "external" "dshield-top10" {
    program = ["powershell", "-nologo", "-executionpolicy", "bypass", "-File", "${path.module}/dshield-top10.ps1"]
}