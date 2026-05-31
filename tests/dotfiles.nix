{
  name = "dotfiles";

  # test system config for virtual machine
  nodes.machine = { ... }: {};

  # python script to test if config is working as expected on virtual machine
  testScript = ''
    machine.start()
    machine.wait_for_unit("default.target")
    machine.succeed("uname -a")
  '';
}
