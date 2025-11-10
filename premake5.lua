-- hwinfo

project "hwinfo"
  kind "StaticLib"
  language "C++"
  cppdialect "c++20"
  staticruntime "On"
  systemversion "latest"

  targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
  objdir ("%{wks.location}/build/" .. outputdir .. "%{prj.name}")

  --IncludeDir["hwinfo"] = "%{wks.location}/libs/hwinfo/include"

  includedirs {
    --"%{IncludeDir.hwinfo}",
  }

  files {
    "premake5.lua",
    "include/**.h",
    "src/**.cpp",
  }

  -- This is for usage of the miss-ocl library
  -- I may consider including it to the project later on
  --
  --defines {
  --    "USE_OCL",
  --    "NOMINMAX"
  --}
  --includedirs {
  --  "external/miss-opencl",
  --  "external/miss-opencl/include",
  --  "external/miss-opencl/external/OpenCL/external/OpenCL-CLHPP/include"
  --}
  --links {
  --  "miss-opencl_static"
  --}

  filter "system:linux"
    pic "On"
    postbuildmessage "Copying PCI id list in ~/.hwinfo/pci.ids"
    postbuildcommands {
        "mkdir -p ~/.hwinfo",
        "cp scripts/pci.ids ~/.hwinfo/pci.ids"
    }
  
  filter "system:macosx"
    pic "On"

  filter "configurations:Debug"
    runtime "Debug"
    symbols "On"

  filter "configurations:Release"
    runtime "Release"
    optimize "On"

  usage "PUBLIC"
    includedirs { "./include" }

  usage "INTERFACE"
    links { "hwinfo" }
