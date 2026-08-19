let
    all = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8wgAowUsbo8EZbiVOtu3T7UVSQvJ/PhD7C+CoTMy91";
in
{
    age.secrets = {
        porkbunAPIKey.file = ./porkbun-api-key.age;
        porkbunAPISecretKey.file = ./porkbun-api-secret-key.age;
    };

    "porkbun-api-key.age".publicKeys = [ all ];
    "porkbun-api-secret-key.age".publicKeys = [ all ];
}
