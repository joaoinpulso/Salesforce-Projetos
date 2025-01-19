public class RandomContactFactory {
    public static List <Contact> generateRandomContacts (Integer numContacts, String lastname) {
        List <Contact> cont = new List <Contact>();
        for (Integer i = 0; i < numContacts; i++) {
            Contact c = new Contact(FirstName = 'Teste' + i,LastName = lastname);
            cont.add(c);
        }
        return cont;
    }

}