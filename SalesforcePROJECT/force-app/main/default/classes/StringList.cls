public with sharing class StringList {
    public static List<String> generateStringList(Integer num) {
        List <String> ListadeString = new List <String> ();

        for (Integer i = 0; i < num; i++) {
            ListadeString.add('Test ' + i);
            System.debug(ListadeString);
        }
        

        return ListadeString;

    }
}