# SimuldorEP
Las señales obtenidas mediante simulación pueden ser usadas para evaluar o comparar diferentes técnicas de procesamiento digital de señales o algoritmos de aprendizaje automático (machine learning), 
dando la posibilidad a los investigadores de contar con señales de pruebas ilimitadas para el desarrollo de dichos experimentos. El monitoreo de la actividad cerebral a partir de los registros electroencefalograficos
cuenta con una gran popularidad, pero la evaluación de los métodos de análisis de esta señal es una tarea difícil, porque generalmente no existe un estándar de oro que permita la comparación. 
Sin embargo, con el objetivo de evaluar distintos métodos propuestos para el análisis de estas señales, los investigadores a menudo proponen el uso de señales simuladas,
en lugar de señales reales, las cuales muchas veces responden a modelos simplistas alejados de la realidad. En este caso se propone una herramienta para la simluación de potenciales relacionados con eventos, llamada SimuladorEP.
La herramienta propuesta permite la simulación de potenciales relacionados con eventos de forma flexible, permitiendo variar diferentes parámetros como la latencia de las respuestas, 
ajustar la modulación de la amplitud y la forma de la onda. El simulador tiene en cuenta los efectos de muestreo y cuantización que pueden darse en un escenario real, 
además de las características del ruido y las interferencias. A partir de los registros simulados, la herramienta brinda la posibilidad de comparar diferentes combinaciones entre métodos de eliminación de tendencias y 
métodos de promedio en la obtención de la forma de onda de la respuesta evocada. 
La comparación de los resultados se realiza a partir de la estimación de la relación señal a ruido (SNR) y la comparación visual de las formas de ondas obtenidas luego de promediar.
