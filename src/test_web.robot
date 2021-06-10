*** Settings ***
Library    SeleniumLibrary
Resource    ../utils/keywords.robot
Test Teardown    Close Browser

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
   
Deuxieme test qui plnat
    Log    Avant set suite variable ${toto}
    Set Suite Variable    ${toto}    valuetoto2
    Log    La on va se connecter ${toto}
    #Open Browser    http://ats.faimerecruiter.com/    firefox
    Connexion    admin    admin2
    
Test creation job orders
    Open Browser    http://ats.faimerecruiter.com/    chrome
    Connexion    admin    admin
    #Creer Job Orders    toto
    Ouvrir Onglet    Job Orders
    Creer Job Orders    new_job_orders_test2    Internal Postings    Toulosue    FR    ballot, Brice    DJOKO, Gérard    C2H    3    Batman est plus fort que Superman
    
Test modification job orders
    Open Browser    http://ats.faimerecruiter.com/    chrome
    Connexion    admin    admin
    Modifier Job Orders    new_job_orders_test2    new_job_orders_test_futur    Digitalair    Toulouse    FRENCH    ballot, Brice    DJOKO, Gérard    C2H    3    Batman est plus fort que Superman et que Wonderwoman réunis !
    

Test keyword ouvrir onglet argument optionnel
    Open Browser    http://ats.faimerecruiter.com/    chrome
    Connexion    admin    admin
    #Creer Job Orders    toto
    Ouvrir Onglet    Reports
    Ouvrir Onglet    Settings    1
    Ouvrir Onglet    Job Orders    autre_parametre_optionnel=true