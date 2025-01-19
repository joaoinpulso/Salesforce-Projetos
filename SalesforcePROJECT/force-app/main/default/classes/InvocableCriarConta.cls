public  class InvocableCriarConta {
    @InvocableMethod
    public static List <ClasseRetorno>  recebeValores (List <RecebeVariaveis> var) {

        criaConta(var);

        ClasseRetorno retorno = new ClasseRetorno();
        retorno.mensagem = 'Deu certo';

        return new List <ClasseRetorno> {retorno};

    }

    private static void criaConta(List <RecebeVariaveis> var) {

        List <Account> accLista = new List <Account>();
            for (RecebeVariaveis vr : var) {
                Account acc = new Account();
                acc.Name = vr.variaveisRecebidas.nomeConta;
                acc.Phone = vr.variaveisRecebidas.telefone;
                acc.CPF__c = String.valueOf(vr.variaveisRecebidas.cpf);

                accLista.add(acc);
            }
            insert accLista;
    }

    public class RecebeVariaveis {
        
       @InvocableVariable 
       public ObjectVirtualVO variaveisRecebidas;

    }

    public class ClasseRetorno {
       @InvocableVariable 
       public String mensagem;

    }
}