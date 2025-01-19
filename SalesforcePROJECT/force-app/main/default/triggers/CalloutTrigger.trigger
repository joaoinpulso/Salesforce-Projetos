trigger CalloutTrigger on Account (before insert, before update) {
    /*executando um método futuro que faz um callout de forma assincrona a partir de uma trigger*/
    CalloutClass.makeCallout();
}