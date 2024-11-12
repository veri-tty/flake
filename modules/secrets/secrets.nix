let
  # user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILJvxqkixr3AcKJgujRsm/GPwEnwcOCalnGxkV4idOnq";
  # user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILI6jSq53F/3hEmSs+oq9L4TwOo1PrDMAgcA1uo1CCV/";
  # users = [user1 user2];
  cathedral = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILJvxqkixr3AcKJgujRsm/GPwEnwcOCalnGxkV4idOnq";
  roamer = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [cathedral];
in {
  "secret1.age".publicKeys = [cathedral];
  "secret2.age".publicKeys = users ++ systems;
}
