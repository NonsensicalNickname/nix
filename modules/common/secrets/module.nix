{ inputs, ... }:
{
    environment.systemPackages = [
        inputs.agenix.packages.x86_64-linux.default
    ];

    age.identityPaths = [
        "/home/ceri/.ssh/secrets_ed25519"
    ];

    age.secrets = {
        porkbunAPIKey.file = ./porkbunAPIKey.age;
        porkbunAPISecretKey.file = ./porkbunAPISecretKey.age;
    };
}
