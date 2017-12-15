namespace Application {
    void main (string[] args) {
        Test.init (ref args);
        
        Test.add_func ("/if_parameters_can_be_set", () => {

            string name = "strawberry";
            string ip = "127.0.0.1";
            string user = "nutty";
            int port = 8080;
            string forwardAgent = "yes";
            string proxyCommand = "ssh vivek@Jumphost nc FooServer 22"; 

            Bookmark bookmark = new Bookmark ();
            bookmark.setName(name);
            bookmark.setIp(ip);
            bookmark.setUser(user);
            bookmark.setPort(port);
            bookmark.setForwardAgent(forwardAgent);
            bookmark.setProxyCommand(proxyCommand);

            assert(bookmark.getName() == name);
            assert(bookmark.getIp() == ip);
            assert(bookmark.getUser() == user);
            assert(bookmark.getPort() == port);
            assert(bookmark.getForwardAgent() == forwardAgent);
            assert(bookmark.getProxyCommand() == proxyCommand);
        });

        Test.run ();
    }
}
