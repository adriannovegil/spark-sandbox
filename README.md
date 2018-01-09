# SparkPremer-BDE Sandbox

Proyecto para aprovisionar un entorno de pruebas para el desarrollo del algoritmo SparPremer.

## Compatibilidad

 * [CentOS 7](https://www.centos.org/)
 * [BDEv3](http://bdev.des.udc.es/)

## Creando el Sandbox

Lo primero que tenemos que hacer es clonar este repositório.

```
 $ git clone [REPO_URL]
```

## Configuramos el Entorno

Creamos el fichero ```config```. Podemos hacerlo copiando el fichero de template que acompaña al proyecto.

```
 $ cp config.json.template config.json
```

Una vez que hemos creado nuestro fichero podemos llevar a cabo la configuración de nuestro servidor.

A continuación se pueden ver las principales opciones de configuración disponibles.

### Configuración General

```
"bde-master": {
    "enabled": true,
    "guest-hostname": "bde-master.vm.server",
    "group": "PREMER-BDE Sandbox",
    "box": "bento/centos-7.2",
    "timezone": "Europe/Madrid",
    "cpus": 1,
    "memory": 2048,
    "ssh-prv-key": "~/.ssh/id_rsa",
    "ssh-pub-key": "~/.ssh/id_rsa.pub",
    "network": {
      "interfaces": [
        {
          "network-type": "private",
          "if-adapter": "eth1",
          "if-inet-type": "static",
          "if-address": "10.0.9.20",
          "if-netmask": "255.255.0.0"
        }
      ]
    },
    "scripts": [
        "bootstrap.sh",
        "ssh.sh",
        "java.sh",
        "bde.sh"
    ]
},
```

| Parámetro             |  Valor(es)                                                        |
| --------------------- | ----------------------------------------------------------------- |
| `enabled`             | `true` si queremos que Vagrant cree la instancia, en caso contrario ignora el bloque de configuración. Esto se usa sobre todo cuando aprovisionamos más de una máquina desde el mismo repositorio         |
| `guest-hostname`      | Hostname de la instancia                                          |
| `group`               | Si queremos agrupar las instancias. En VirtualBox esta opción se traduce en que las máquinas virtuales que tengan este label se agruparan juntas |
| `box`                 | Vagrant Box                                                       |
| `timezone`            | Server timezone                                                   |
| `cpus`                | Número de CPUs de la instancia                                    |
| `memory`              | Cantidad de memoria de la instancia                              |
| `ssh-prv-key`         | Clave privada para acceder a la instancia. Si no indicamos nada, Vagrant intenta inyectar una clave por defecto                         |
| `ssh-pub-key`         | Clave pública para acceder a la instancia. Si no indicamos nada, Vagrant intenta inyectar una clave por defecto                         |
| `scripts`             | Listado de scripts que queremos utilizar en la etapa de provisioning  |

### Configuración de Red

A continuación se muestran los parámetros más habituales para la configuración de red.

```
"network": {
  "interfaces": [
    {
      "network-type": "private",
      "if-adapter": "eth1",
      "if-inet-type": "static",
      "if-address": "10.0.8.20",
      "if-netmask": "255.255.0.0"
    }
  ]
},
```

| Parámetro             |  Valor(es)                                                        |
| --------------------- | ----------------------------------------------------------------- |
| `network-type`        | `Private` ó `Public` [Vagrant documentation](https://www.vagrantup.com/docs/getting-started/networking.html) |
| `if-adapter`          | El nombre del adaptador de red, p.e. eth0, eth1, etc.    |
| `if-inet-type`        | `static` ó nada. [Vagrant documentation](https://www.vagrantup.com/docs/getting-started/networking.html) |
| `if-address`          | Dirección ip que queremos asignar a la interfaz                   |
| `if-netmask`          | Mascara de red                                                    |
| `bridge-adapter`      | Modo de configuración de la interfaz. [Vagrant documentation](https://www.vagrantup.com/docs/networking/public_network.html)    |

## Arrancando la Instancia

Una vez que tenemos el entorno configurado, podemos ejecutar la instancia ejecutando el siguiente comando:

```
 $ vagrant up
```

## Administrando la Instancia

A continuación se muestran los comandos más típicos necesarios para la gestión de las instancias.

| Comando                              |  Descripción                                      |
| ------------------------------------ | ------------------------------------------------- |
| `$ vagrant status`                   | Ver el estado de la instancia                     |
| `$ vagrant ssh [instance-id]`        | Conectarse a la instancia via SSH                 |
| `$ vagrant suspend [instance-id]`    | Suspender la instancia                            |
| `$ vagrant halt [instance-id]`       | Parar la instancia                                |
| `$ vagrant destroy [instance-id]`    | Destruir la instancia                             |

## Configuración del framework BDEv3

 * Si hay cambios en las interfaces de red, hay que ajustar el fichero ```system-default.sh```. Concretamente las variables ```GBE_INTERFACE``` y ```IPOIB_INTERFACE```.
 * Hay que ajustar la lista de direcciones ip del cluster. Para ello editamos el fichero ```hostfile``` donde indicaremos en primer lugar la IP del nodo master, y acontinuación las direcciones ip de los nodos slave.
