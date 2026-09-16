package com.cars.project;

import net.minecraftforge.fml.common.Mod;
import net.minecraftforge.fml.common.event.FMLInitializationEvent;

@Mod(modid = "cars", name = "Cars", version = "1.0.0-SNAPSHOT")
public class Cars {
    @Mod.EventHandler
    public void init(FMLInitializationEvent event) {
        System.out.println("Hello from Legacy Forge!");
    }
}
