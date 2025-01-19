public with sharing class TesteMap {
    public TesteMap() {
        List<String> lista = new List<String> {
            'João_24 ',
            'Maria_25',
            'Pedro_26',
            'José_27',
            'Carlos_28',
            'Ana_29',
            'Luiz_30',
            'Bruno_31',
            'Paulo_32'
        };

        Map <String, Map<String, Integer>> mapeiaLista = new Map<String, Map<String, Integer>>();
            for (String name : lista){
                List <String> quebra = name.split('_');

                if (mapeiaLista.containsKey(quebra[0])) {
                    mapeiaLista.get(quebra[0]).put(quebra[1], mapeiaLista.get(quebra[0]).get(quebra[1]) + 1);
                    
                } else {
                    mapeiaLista.put(quebra[0], new Map<String, Integer> {quebra[1] => 1});
                    
                }
                system.debug(mapeiaLista);

            }


    }
}