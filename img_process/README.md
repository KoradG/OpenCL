# Féléves feladat leírása

Ez a projekt egy egyszerű képfeldolgozó alkalmazás, OpenCL használatával.

## Kernelek

### Sobel kernel

A Sobel kernel a klasszikus éldetektáló algoritmus alapján működik. Az algoritmus két mátrixot használ a kép általános szürkeségi értékének közelítésére és a gradient meghatározására. 
Az éldetektálás során a kernel elvégez egy konvolúciót az eredeti képpel, majd megkeresi az élek irányát és erejét. Az eredmény egy fekete-fehér kép, ahol az élek fehér pixelekkel vannak jelölve.

### Smooth kernel

A Smooth kernel egy egyszerű, középértékszűrő algoritmust alkalmaz a bemeneti képre. Az algoritmus egy adott pixel környezetében átlagolja a színeket, így simábbá téve a képet. 
Ez a simított kép lehetővé teszi az élek és zajok csökkentését, ami előnyös lehet további feldolgozási feladatokhoz.

## Python program

A Python program feladata a képfeldolgozási folyamat vezérlése és az eredmények megjelenítése. A program az OpenCL-t használ a kernelek végrehajtásához, 
majd megjeleníti az eredményeket a felhasználó számára. A program egyszerűen kezelhető parancssori felhasználói felülettel rendelkezik.
## Követelmények

- Python 3.x
- NumPy
- Matplotlib
- OpenCL támogatású hardver és illesztőprogram
