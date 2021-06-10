def ecriture_dans_fichier(filename,data):
    print (filename)
    # J'ouvre mon fichier "filename" en ecriture
    logFile = open(filename, "a")
    # J'ecris "data" dans ce fichier
    logFile.write(data+chr(10))
    # Je ferme ce fichier
    age_du_capitaine = 42
    logFile.close
    return age_du_capitaine