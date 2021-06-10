*** Settings ***
Library    SeleniumLibrary
Resource    ../utils/keywords.robot

*** Variables ***
${toto}    defaut
    
*** Test Cases ***
Premier test web avec connexion
    Log    Au tout debut ${toto}
    Set Suite Variable    ${toto}    valuetoto    
    Log    La on va se connecter ${toto}
    Open Browser    http://ats.faimerecruiter.com/    firefox
    Connexion    admin    admin
    Capture Page Screenshot