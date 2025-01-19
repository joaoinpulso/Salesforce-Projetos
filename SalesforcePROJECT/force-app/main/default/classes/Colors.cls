public with sharing class Colors {
    public Colors() {

        //Crie uma lista e adicione elementos
        List<String> colors = new List<String>{'Red', 'Green', 'Blue'};
        
        //adicione elementos a lista depois de criada
        List<String> moreColors = new List<String> ();
        moreColors.add('orange');
        moreColors.add('purple');
    
        
        //get elementos da lista
        String color1 = moreColors.get(0);
        String color2 = moreColors[0];
        System.assertEquals(color1, color2);

        //itere na lista para ler os elementos
        System.debug('saida de colors em moreColors:');

        for (String color : moreColors) {
            // valor de debug log
            System.debug('ssdsds'+color);
        
    }
    
    }


 


}