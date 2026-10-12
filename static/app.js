// --- FILTRO ANTIDUPLICADOS PARA "CONTINUAR VIENDO" ---
function limpiarContinuarViendo(dataHistorial) {
    const unicosMap = {};
    
    dataHistorial.forEach(item => {
        // Limpiamos el nombre para extraer la serie base (quita Temporada, Episodio, S01E02, etc.)
        let nombreBase = item.nombre
            .replace(/temporada\s*\d+|temp\s*\d+|s\d+e\d+|capitulo\s*\d+|episodio\s*\d+/gi, '')
            .trim();
        
        if (!nombreBase) nombreBase = item.nombre;
        
        // Guardamos el elemento; como se sobreescribe, queda el más reciente o el último procesado
        unicosMap[nombreBase] = item;
    });
    
    return Object.values(unicosMap);
}
