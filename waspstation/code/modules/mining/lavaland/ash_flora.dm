/obj/structure/flora/ash/fern
	name = "cave fern"
	desc = "A species of fern with highly fibrous leaves."
	harvested_name = "cave fern stems"
	harvested_desc = "A few cave fern stems, missing their leaves."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/fern
	harvest_amount_high = 4
	harvest_message_low = "You clip a single, suitable leaf."
	harvest_message_med = "You clip a number of leaves, leaving a few unsuitable ones."
	harvest_message_high = "You clip quite a lot of suitable leaves."
	regrowth_time_low = 3000
	regrowth_time_high = 5400

/obj/structure/flora/ash/fireblossom
	name = "fire blossom"
	desc = "An odd flower that grows commonly near bodies of lava. The leaves can be ground up for a substance resembling capsaicin."
	harvested_name = "fire blossom stems"
	harvested_desc = "A few fire blossom stems, missing their flowers."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/fireblossom
	needs_sharp_harvest = FALSE
	harvest_amount_high = 3
	harvest_message_low = "You pluck a single, suitable flower."
	harvest_message_med = "You pluck a number of flowers, leaving a few unsuitable ones."
	harvest_message_high = "You pluck quite a lot of suitable flowers."
	regrowth_time_low = 2500
	regrowth_time_high = 4000

/obj/structure/flora/ash/puce
	name = "Pucestal Growth"
	desc = "A collection of puce colored crystal growths."
	harvested_name = "Pucestal fragments"
	harvested_desc = "A few pucestal fragments, slowly regrowing."
	harvest = /obj/item/reagent_containers/food/snacks/grown/ash_flora/puce
	harvest_amount_high = 6
	harvest_message_low = "You work a crystal free."
	harvest_message_med = "You cut a number of crystals free, leaving a few small ones."
	harvest_message_high = "You cut free quite a lot of crystals."
	regrowth_time_low = 10 MINUTES 				// Fast, for a crystal
	regrowth_time_high = 20 MINUTES

//SNACKS

/obj/item/reagent_containers/food/snacks/grown/ash_flora/fern
	name = "fern leaf"
	desc = "A leaf from a cave fern."
	seed = /obj/item/seeds/lavaland/fern
	wine_power = 10

/obj/item/reagent_containers/food/snacks/grown/ash_flora/fireblossom
	name = "fire blossom"
	desc = "A flower from a fire blossom."
	seed = /obj/item/seeds/lavaland/fireblossom
	wine_power = 40

/obj/item/reagent_containers/food/snacks/grown/ash_flora/puce
	name = "Pucestal Crystal"
	desc = "A crystal from a pucestal growth."
	seed = /obj/item/seeds/lavaland/puce
	wine_power = 0		// It's a crystal

//SEEDS

/obj/item/seeds/lavaland/fern
	name = "pack of cave fern seeds"
	desc = "These seeds grow into cave ferns."
	plantname = "Cave Fern"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/fern
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/plant_type/weed_hardy)
	reagents_add = list(/datum/reagent/ash_fibers = 0.10)

/obj/item/seeds/lavaland/fern/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)

/obj/item/seeds/lavaland/fireblossom
	name = "pack of fire blossom seeds"
	desc = "These seeds grow into fire blossoms."
	plantname = "Fire Blossum"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/fireblossom
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/yellow)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.03, /datum/reagent/carbon = 0.05, /datum/reagent/consumable/pyre_elementum = 0.08)

/obj/item/seeds/lavaland/puce
	name = "pack of pucestal seed crystals"
	desc = "These crystals can be grown into larger crystals."
	plantname = "pucestal growth"
	product = /obj/item/reagent_containers/food/snacks/grown/ash_flora/puce
	genes = list(/datum/plant_gene/trait/plant_type/crystal)
	reagents_add = list(/datum/reagent/medicine/puce_essence = 0.10)

/obj/item/seeds/lavaland/puce/Initialize(mapload,nogenes)
	. = ..()
	if(!nogenes)
		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_REMOVABLE)
		unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_REMOVABLE)

		unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)
		unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_EXTRACTABLE)
