# applications_calculator

## Description
Calculator application provide standard calculator and history recording functions.

## Directory
```
├─AppScope
│  │  
│  └─resources                       # Resource file 
├─common
│  │  
│  └─src
│      └─main  
│          └─ets                     # Public methods            
├─feature
│  │
│  └─calculation 
│     │ 
│     └─src
│        └─main
│           └─ets                    # Basic characteristics                                         
├─product
│  │
│  └─phone 
│      └─src
│         └─main 
│              └─ets                 # Mobile / pad program entrance  
├─product
│  │
│  └─pc 
│      └─src
│         └─main 
│              └─ets                 # PC program entrance   
├─open_source                        # Open source declaration of introduced third-party libraries                              
└─hw_sign                            # Signature file
```

## Overall architecture

![](./figures/architecture.png)

Calculator, as a basic application, implements standard calculator and history recording functions.

## Instructions

### Built on IDE

Open the project engineering in DevEco Studio and select Build → Build Haps(s)/APP(s) → Build Hap(s).

![](./figures/build_haps.png)

After compilation, the hap package will be generated in the '\build\outputs' path in the project directory. (If no signature is configured, only unsigned HAP packages will be generated.)

![](./figures/build_output_dir_release.png)

Use the hdc install 'hap package address' command to install the compiled hap package.

![](./figures/hdc_install.png)

Run the OpenHarmony version configuration on the testing machine.

![](./figures/build_profile.png)

Configure SDK according to local environment.

![](./figures/build_sdk.png)

### Built on OpenHarmony version

In the OpenHarmony source code directory, call the command to compile the calculator separately.

```
./build.sh --product-name rk3568 --ccache --build-target calculator
```
> **Instructions：**
--product-name：Product names, such as Hi3516DV300, rk3568, etc.
--ccache：Use caching function during compilation.
--build-target: The name of the compiled component.

## Restraint
- Development environment
    - **DevEco Studio for OpenHarmony**: The Version number is greater than 3.1.1.101, download and install OpenHarmony SDK API Version 11. (You can refer to the IDE documentation for initial IDE configuration.)
- Language version
    - ArkTS
- Restrict
    - This example only supports running on standard systems