-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
	include('organizer-lib')

    -- Load and initialize the include file.
    include('Mote-Include.lua')

end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

    state.OffenseMode:options('Normal', 'Acc', 'Refresh')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
    state.HybridMode:options('Normal','PDT', 'MDT','Meva')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('Normal','PDT')
	state.MagicalDefenseMode:options('Normal','MDT','Meva')
	

	
    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Corrosive Ooze','Cursed Sphere','Entomb','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Regurgitation','Rending Deluge',
        'Retinal Glare','Spectral Floe','Subduction','Tem. Upheaval','Tenebral Crush','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast','Rail Cannon','Diffusion Ray','Scouring Spate'
    }

    -- Magical spells with a primary Agi mod
    blue_magic_maps.MagicalAgi = S{
        'Benthic Typhoon','Silent Storm'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light','Blinding Fulgor'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse','Sub-zero Smash'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades','Anvil Lightning'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Occultation','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Mighty Guard','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard','Pyric Bulwark','Thunderbolt',
        'Tourbillion'
    }

        -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')

    update_combat_form()
    select_default_macro_book()
	determine_haste_group()
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    ---------------------------------

    sets.buff['Burst Affinity'] = {hands=gear.herchands_mb,feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk", feet="Assimilator's Charuqs +1"}
    sets.buff.Convergence = {}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {}
    sets.buff.Efflux = {legs="Hashishin Tayt"}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body="Adhemar jacket",hands="Buremte Gloves",ring1="Sirona's Ring",ring2="Kunaji ring",
        feet=gear.hercfeet_melee}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience orb",
        head="Carmine Mask",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body=gear.fc_tbody,hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Amalric nails"}
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin mintan +1"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Adhemar bonnet",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Abnoba kaftan",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Cornflower Cape",waist="Fotia Belt",legs=gear.herclegs_melee,feet=gear.hercfeet_melee}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {ear1="Telos Earring"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {ammo="Ginsen",
        head="Telchine cap",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Rawhide vest",hands="Leyline gloves",ring1="Sirona's Ring",ring2="Epona's Ring",
        back="Cornflower Cape",waist="Fotia Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}
    
    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Gwati Earring",
        body="Amalric doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Archon Ring",
        back="Cornflower Cape",waist="Eschan Stone",legs="Amalric slops",feet="Mavi basmask +1"}

    sets.precast.WS['Savage Blade'] = {ammo="Floestone",
        head="Adhemar bonnet",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Adhemar jacket",hands=gear.herchands_mb,ring1="Ifrit ring +1",ring2="ifrit ring +1",
        back="Buquwik Cape",waist="Caudata Belt",legs=gear.herclegs_melee,feet=gear.hercfeet_acc }
    
    sets.precast.WS['Chant du Cygne'] = {ammo="Jukukik feather",
        head="Adhemar bonnet",neck="Fotia gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's ring",
        back="Cornflower Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid greaves"}
    
	sets.precast.WS['Chant du Cygne'].Acc = {ammo="Jukukik feather",
        head="Adhemar bonnet",neck="Fotia gorget",ear1="Telos Earring",ear2="Moonshade Earring",
        body="Adhemar jacket",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded Mantle +1",waist="Fotia Belt",legs=gear.herclegs_melee,feet=gear.hercfeet_acc }
    


    
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Sapience orb",
        head="Amalric coif",neck="Voltsurge Torque",ear1="Enchanter earring +1",ear2="Loquacious Earring",
        body="Taeon Tabard",hands="Leyline gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric nails"}
        
    sets.midcast['Enhancing Magic'] = {
        head="Telchine cap",neck="Incanter's Torque",ear1="Andoaa earring",
        body="Telchine Chasuble",hands="Telchine gloves",
        back="Fi follet cape",waist="Olympus sash",legs="Telchine Braconi",feet="Telchine pigaches"}

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],
		{feet=gear.herclegs_dt})

    sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {hands="Hashishin bazubands +1"})
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee}

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Floestone",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Cheruski Needle",
        head="Carmine Mask",neck="Sanctity necklace",ear1="Suppanomimi",ear2="Zennaroi earring",
        body="Adhemar jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Petrov Ring",
        back="Cornflower Cape",waist="Eschan stone",legs=gear.herclegs_melee,feet=gear.hercfeet_melee})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Dosis Tathlum",
        head="Helios band",neck="Sanctity necklace",ear1="Novio Earring",ear2="Friomisi Earring",
        body="Amalric doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Cornflower Cape",waist="Eschan Stone",legs="Amalric slops",feet="Amalric nails"}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {neck="Sanctity Necklace",back="Cornflower cape"})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {hands="Hashishin Bazubands +1",ring1="Globidonta Ring",ring2="Shiva Ring +1",waist="Eschan Stone",
		back="Cornflower cape"})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Mavi Tathlum",
        head="Amalric coif",neck="Sanctity necklace",ear1="Enchanter earring +1",ear2="Gwati Earring",
        body="Samnuha coat",hands="Rawhide gloves",ring1="Shiva ring +1",ring2="Weatherspoon Ring",
        back="Cornflower cape",waist="Eschan Stone",legs="Hashishin tayt +1",feet="Hashishin Basmak +1"}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Amalric coif",neck="Combatant's torque",ear1="Enchanter earring +1",ear2="Gwati Earring",
        body="Samnuha coat",hands="Leyline gloves",ring1="Petrov Ring",ring2="Kunaji Ring",
        back="Twilight Cape",waist="Eschan stone",legs="Carmine cuisses",feet=gear.hercfeet_melee}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
        
    sets.midcast['Blue Magic']['White Wind'] = { ammo="Psilomene",
        head="Telchine cap",neck="Sanctity necklace",ear1="Calamitous Earring",ear2="Loquacious Earring",
        body="Vrikodara jupon",hands="Buremte Gloves",ring1="Asklepian Ring",ring2="Kunaji Ring",
        back="Solemnity cape",waist="Gishdubar Sash",legs="Telchine braconi",feet="Telchine pigaches" }

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Enhancing Magic'], 
		{head="Amalric coif"})
	
	sets.midcast['Blue Magic']['Barrier Tusk'] = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff,{legs=gear.herclegs_dt})
	
    sets.midcast['Blue Magic'].Healing = {
        head="Telchine Cap",neck="Incanter's Torque",ear1="Beatific Earring",ear2="Calamitous earring",
        body="Vrikodara jupon",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Solemnity cape",waist="Bishop's Sash",legs="Carmine cuisses",feet="Telchine pigaches"}

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        neck="Incanter's Torque",
		hands="Hashishin Bazubands +1",
        back="Cornflower Cape",legs="Hashishin tayt"}

    sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, {hands="Hashishin bazubands +1"})
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",hands="Magus Bazubands"}
        --head="Luhlaza Keffiyeh",  
        --body="Assimilator's Jubbah",hands="Magus Bazubands",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
        
    -- Idle sets
    sets.idle = {ammo="Sapience Orb",
        head="Rawhide mask",neck="Loricate torque +1",ear1="Telos Earring",ear2="Infused Earring",
        body="Mekosu. Harness",hands=gear.herchands_dt,ring1=gear.DarkRing.PDT,ring2="Defending Ring",
        back="Solemnity Cape",waist="Flume Belt +1",legs="Amalric slops",feet="Ahosi leggings"}

    sets.idle.PDT = {ammo="Brigantia pebble",
        head="Lithelimb cap",neck="Loricate torque +1",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands=gear.herchands_dt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume Belt +1",legs=gear.herclegs_dt,feet="Ahosi leggings"}

	sets.idle.MDT = {ammo="Vanir Battery",
        head="Amalric coif",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Eabani earring",
        body="Mekosu. Harness",hands=gear.herchands_dt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Flume belt +1",legs=gear.herclegs_dt,feet="Ahosi leggings"}

    sets.idle.Town = {ammo="Sapience Orb",
        head="Rawhide mask",neck="Loricate torque +1",ear1="Telos Earring",ear2="Infused Earring",
        body="Mekosu. Harness",hands=gear.herchands_dt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume Belt +1",legs="Carmine cuisses",feet="Ahosi leggings"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {ammo="Brigantia pebble",
        head="Lithlelimb cap",neck="Loricate torque +1",ear1="Impregnable Earring",ear2="Genmei Earring",
        body="Vrikodara jupon",hands=gear.herchands_dt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity Cape",waist="Flume Belt +1",legs=gear.herclegs_dt,feet="Ahosi leggings" }

    sets.defense.MDT = {ammo="Vanir battery",
        head="Amalric coif",neck="Loricate torque +1",ear1="Sanare Earring",ear2="Eabani earring",
        body="Amalric doublet",hands=gear.herchands_dt,ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Flume Belt +1",legs=gear.herclegs_dt,feet="Ahosi leggings" }
    sets.defense.Meva = {ammo="Vanir battery",
        head="Amalric coif",neck="Warder's charm",ear1="Sanare Earring",ear2="Eabani earring",
        body="Amalric doublet",hands="Leyline gloves",ring1="Defending Ring",ring2=gear.DarkRing.PDT,
        back="Solemnity cape",waist="Flume Belt +1",legs=gear.herclegs_dt,feet="Ahosi leggings" }

    sets.Kiting = {legs="Carmine cuisses"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {sub="Genmei shield",ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity necklace",ear1="Brutal earring",ear2="Telos earring",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.hercfeet_melee}
    sets.engaged.Acc = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity necklace",ear1="Brutal earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.hercfeet_melee}
    sets.engaged.Refresh = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Lissome Necklace",ear1="Brutal earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_melee}

		--Standard DW engaged set 0% haste
    sets.engaged.DW = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity necklace",ear1="Eabani earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_melee}
    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Carmine mask",neck="Combatant's torque",ear1="Eabani earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded mantle +1",waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.hercfeet_melee }
	sets.engaged.DW.PDT = {ammo="Brigantia pebble",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Impregnable earring", ear2="Genmei earring",
		body="Adhemar jacket", hands=gear.herchands_dt, ring1="Defending ring", ring2="Rajas Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings"}
	sets.engaged.DW.Acc.PDT = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Genmei earring",
		body="Adhemar jacket", hands=gear.herchands_dt, ring1="Defending ring", ring2="Rajas Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.MDT = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Eabani earring",
		body="Adhemar jacket", hands=gear.herchands_melee, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.Meva = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Eabani earring",
		body="Adhemar jacket", hands=gear.herchands_melee, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }

		
		--High Haste engaged sets, approx 30% haste
    sets.engaged.DW.HighHaste = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity necklace",ear1="Brutal earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.hercfeet_melee}
    sets.engaged.DW.Acc.HighHaste = {ammo="Ginsen",
        head="Carmine mask",neck="Combatant's torque",ear1="Telos earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands=gear.herchands_melee,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded mantle +1",waist="Olseni belt",legs="Samnuha Tights",feet=gear.hercfeet_melee }
	sets.engaged.DW.PDT.HighHaste = {ammo="Brigantia pebble",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Impregnable earring", ear2="Genmei earring",
		body="Adhemar jacket", hands=gear.herchands_dt, ring1="Defending ring", ring2="Rajas Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings"}
	--sets.engaged.DW.Meva.HighHaste = {ammo="Vanir battery",
		--head="Adhemar Bonnet", neck="warder's charm", ear1="Sanare earring", ear2="Eabani earring",
		--body="Adhemar jacket", hands=gear.herchands_melee, ring1="Defending ring", ring2="Epona's Ring",
		--back="Engulfer cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.PDT.HighHaste = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Genmei earring",
		body="Adhemar jacket", hands=gear.herchands_dt, ring1="Defending ring", ring2="Rajas Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.MDT.HighHaste = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Sanare earring",
		body="Adhemar jacket", hands=gear.herchands_melee, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.Meva.HighHaste = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Eabani earring",
		body="Adhemar jacket", hands=gear.herchands_melee, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	
		--Max Haste engaged sets, approx 43.75% haste
    sets.engaged.DW.MaxHaste = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity necklace",ear1="Brutal earring",ear2="Telos earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet belt +1",legs="Samnuha Tights",feet=gear.hercfeet_acc}
    sets.engaged.DW.Acc.MaxHaste = {ammo="Ginsen",
        head="Carmine mask",neck="Combatant's torque",ear1="Telos earring",ear2="Zennaroi earring",
        body="Abnoba kaftan",hands=gear.herchands_acc,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded mantle +1",waist="Olseni belt",legs="Samnuha Tights",feet=gear.hercfeet_acc }
	sets.engaged.DW.PDT.MaxHaste = {ammo="Brigantia pebble",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Impregnable earring", ear2="Genmei earring",
		body="Abnoba kaftan", hands=gear.herchands_dt, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings"}
	sets.engaged.DW.Acc.PDT.MaxHaste = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Genmei earring",
		body="Abnoba kaftan", hands=gear.herchands_acc, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.MDT.MaxHaste = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Genmei earring",
		body="Abnoba kaftan", hands=gear.herchands_acc, ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
	sets.engaged.DW.Acc.Meva.MaxHaste = {ammo="Ginsen",
		head="Adhemar Bonnet", neck="Combatant's torque", ear1="Telos earring", ear2="Zennaroi earring",
		body="Adhemar jacket", hands=gear.herchands_acc , ring1="Defending ring", ring2="Epona's Ring",
		back="Solemnity cape", waist="Flume Belt +1", legs=gear.herclegs_melee, feet="Ahosi leggings" }
		
    sets.engaged.RefreshWeapons = {main="Colada",sub="Colada"}

    sets.engaged.Nuke = {main="Nibiru cudgel",sub="Nibiru cudgel"}


    sets.engaged.DW.Refresh = {ammo="Ginsen",
        head="Rawhide mask",neck="Combatant's torque",ear1="Telos earring",ear2="Suppanomimi",
        body="Mekosu. Harness",hands=gear.herchands_dt,ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Flume Belt +1",legs=gear.herclegs_melee,feet="Ahosi leggings"}


    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
	sets.TreasureHunter = {waist="Chaac Belt"}
    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if S{'haste','march','embrava','haste samba','mighty guard'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        handle_equipping_gear(player.status)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
	determine_haste_group()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    
    if buffactive[604] == 1 and buffactive.haste then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.haste == 2 then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.haste == 1 then
		classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 8)
    else
        set_macro_page(1, 8)
    end
end

