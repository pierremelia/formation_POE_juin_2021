*** Test Cases ***
test1
    Log    Ceci est mon premier test
    
test2
    Log    Ceci est mon deuxieme test qui ne fait pas grand chose...
    Log    adzad
    Log    adzzadzadzad
    
test3quiplante
    Log    Attention je vais planter..
    Log    la variable test name=${TEST_NAME}
    Log To Console    dans la console    
   
    Fail    Erreur voulue
    
test4quifonctionne
    ${name}=    Set Variable    World
    Log    Hello ${name}