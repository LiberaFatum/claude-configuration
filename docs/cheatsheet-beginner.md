# Beginner Cheatsheet

For people new to programming or new to Claude Code. Read this once, refer back as needed.

---

## First time in a project

Type one command:

```
/switch-tier beginner
```

It creates `CLAUDE.md` and sets the easy mode (plain language, asks before acting).
That's the entire onboarding.

---

## Four things to know about the chat

| Symbol | What it does | Example |
|--------|--------------|---------|
| `@` | Reference a file or folder | `Read @src/auth.py and explain what it does` |
| `!` | Run a shell command | `! ls` or `! npm install` |
| `/` | Run a Claude command | `/plan`, `/code-review` |
| `Esc` | Interrupt Claude mid-response | Press it when Claude is going wrong |

Use `@` constantly. It is the single biggest difference between vague prompts
and precise ones — Claude reads the exact file you point at instead of guessing.

---

## Five commands that matter

| Command | When to use it |
|---------|----------------|
| `/plan "what to build"` | Before any non-trivial task. Claude shows a plan, you approve. |
| `/code-review` | After Claude writes code. Catches bugs before they land. |
| `/verify` | Before committing. Runs build + tests + lint + typecheck. |
| `/compact` | Between different tasks. Frees memory, saves money. |
| `/switch-tier <level>` | Change skill mode (beginner / intermediate / advanced). |

Skip everything else until you genuinely need it.

---

## Prompt quality examples

The single biggest factor in cost and result quality is your prompt.
You don't need to know how to code — just describe clearly what you see and what you want.

### 1. Building something

| Bad | Better |
|-----|--------|
| `make a login page` | `I want a login page where users type their email and password. It should look like the signup page I already have. After logging in, go to the main page.` |

Why: The bad version gives Claude no direction — it invents everything from scratch.
The better version describes what the page should do and how it should look.

### 2. Fixing a bug

| Bad | Better |
|-----|--------|
| `fix the error` | `When I upload a file bigger than 10 MB, I get an error page instead of a message. I want it to say "File too large" instead of crashing.` |

Why: The bad version makes Claude guess which error you mean. The better version
describes what happens, when it happens, and what you want instead.

### 3. Adding a feature

| Bad | Better |
|-----|--------|
| `add search` | `I want a search box on the product list page. When I type a name, the list should show only matching products. It shouldn't matter if I use uppercase or lowercase.` |

Why: "Add search" could mean ten different things. The better version describes
the exact behavior so there's nothing to guess.

### 4. Asking a question

| Bad | Better |
|-----|--------|
| `why doesnt this work` | `The login stopped working — it says the token is invalid even when I log in with the right password. Can you check why?` |

Why: "Why doesn't this work" gives Claude nothing to go on. The better version
describes the symptom, so Claude can find the cause.

### 5. Changing existing code

| Bad | Better |
|-----|--------|
| `clean up this code` | `I noticed the price formatting looks the same in several places. Can you put it in one place so I only have to change it once?` |

Why: "Clean up" is subjective. The better version describes one specific thing
with a clear outcome you can check.

---

## Best workflow practices

### How to work with Claude

```
1. Describe what you want                # in plain language
2. Read Claude's plan                    # if something is wrong, say what
3. Say "go ahead"                        # Claude writes the code
4. Look at what changed                  # skim the edits, ask if anything is unclear
5. Ask Claude to save your work          # "commit this"
```

That's it. As you get comfortable, you can add `/code-review` after step 3
and `/verify` before step 5 — but don't worry about them right away.

### Commit often, in small pieces

After every working feature, commit. If you batch a day's work into one commit
and something breaks at the end, you cannot undo selectively — you lose
everything. Five small commits are recoverable; one giant commit is not.

### Read what Claude changes as it works

Claude shows each file edit. Skim them. If something looks wrong (new file you
didn't ask for, dependency you don't recognize, line you don't understand),
stop it with `Esc` and ask. Don't save problems for the `/code-review` step —
catching them earlier costs less.

### One thing at a time

Resist "while you're at it, also do X." Each session should be one feature or
one bug. If you mix tasks, the diff is too messy to review and you can't tell
which change broke which thing.

### When to stop and step in

Stop letting Claude work and step in yourself when:
- It has tried the same fix two or three times
- The plan is much bigger than you expected (5+ files when you wanted 1)
- It is creating new files you didn't ask for
- The error message means nothing to you — read it, search it, then come back

### When you don't understand something

Ask. "Explain what this function does in plain English" is a valid prompt.
Don't accept code you can't read — eventually it will break and you won't be
able to fix it.

---

## Three things that waste your money

1. **Letting Claude grind on the same error.** If it fails twice, stop and read the
   error yourself. Tell Claude what you actually see. Don't say "try again."

2. **Carrying old context between unrelated tasks.** When you switch topics, run
   `/compact`. Otherwise every prompt re-bills the whole previous conversation.

3. **Vague prompts.** "Make it better" costs the same to send as a specific prompt
   but produces wrong code that costs 10x more to fix.

---

# Cheatsheet pro začátečníky (CZ)

Pro lidi nové v programování nebo v Claude Code. Přečti si jednou, vrať se když potřebuješ.

---

## První použití v projektu

Napiš jeden příkaz:

```
/switch-tier beginner
```

Vytvoří `CLAUDE.md` a zapne snadný režim (jednoduchý jazyk, ptá se před akcí).
To je celé nastavení.

---

## Čtyři věci o chatu, co musíš vědět

| Symbol | Co dělá | Příklad |
|--------|---------|---------|
| `@` | Odkaz na soubor nebo složku | `Přečti @src/auth.py a vysvětli co dělá` |
| `!` | Spustí shell příkaz | `! ls` nebo `! npm install` |
| `/` | Spustí Claude příkaz | `/plan`, `/code-review` |
| `Esc` | Přeruší Clauda během odpovědi | Stiskni když Claude jde špatně |

Používej `@` neustále. Je to největší rozdíl mezi vágními prompty a přesnými —
Claude přečte přesně ten soubor, na který ukážeš, místo aby hádal.

---

## Pět příkazů, které se vyplatí

| Příkaz | Kdy ho použít |
|--------|---------------|
| `/plan "co chceš udělat"` | Před každým větším úkolem. Claude ukáže plán, ty schválíš. |
| `/code-review` | Po napsání kódu. Odhalí bugy před commitnutím. |
| `/verify` | Před commitem. Spustí build + testy + lint + typecheck. |
| `/compact` | Mezi různými úkoly. Uvolní paměť, šetří peníze. |
| `/switch-tier <úroveň>` | Změna režimu (beginner / intermediate / advanced). |

Vše ostatní přeskakuj dokud to opravdu nepotřebuješ.

---

## Příklady kvality promptů

Tvůj prompt je největší faktor pro cenu i kvalitu výsledku.
Nemusíš umět programovat — stačí jasně popsat co vidíš a co chceš.

### 1. Stavět něco

| Špatně | Lépe |
|--------|------|
| `udělej přihlašovací stránku` | `Chci přihlašovací stránku, kde uživatel zadá email a heslo. Měla by vypadat jako ta registrační, co už mám. Po přihlášení přejít na hlavní stránku.` |

Proč: Špatná verze nedává Claudovi žádný směr — vymyslí všechno od nuly.
Lepší verze popisuje co má stránka dělat a jak má vypadat.

### 2. Opravit bug

| Špatně | Lépe |
|--------|------|
| `oprav tu chybu` | `Když nahraju soubor větší než 10 MB, místo zprávy se ukáže chybová stránka. Chci aby se zobrazilo "Soubor je příliš velký" místo pádu.` |

Proč: Špatná verze nechá Clauda hádat kterou chybu myslíš. Lepší verze
popisuje co se děje, kdy se to děje a co chceš místo toho.

### 3. Přidat funkci

| Špatně | Lépe |
|--------|------|
| `přidej vyhledávání` | `Chci vyhledávací pole na stránce se seznamem produktů. Když začnu psát název, seznam ukáže jen odpovídající produkty. Nezáleží na velkých a malých písmenech.` |

Proč: "Přidej vyhledávání" může znamenat deset věcí. Lepší prompt popisuje
přesné chování, takže není co hádat.

### 4. Položit otázku

| Špatně | Lépe |
|--------|------|
| `proč to nefunguje` | `Přihlašování přestalo fungovat — píše že token je neplatný, i když zadám správné heslo. Můžeš zjistit proč?` |

Proč: "Proč to nefunguje" nedává Claudovi nic, s čím by mohl pracovat. Lepší
verze popisuje příznak, takže Claude může najít příčinu.

### 5. Změnit existující kód

| Špatně | Lépe |
|--------|------|
| `vyčisti tenhle kód` | `Všiml jsem si, že formátování cen vypadá stejně na několika místech. Můžeš to dát na jedno místo, ať to nemusím měnit víckrát?` |

Proč: "Vyčisti" je subjektivní. Lepší prompt má jeden konkrétní výsledek,
který jde ověřit.

---

## Nejlepší workflow praktiky

### Jak pracovat s Claudem

```
1. Popiš co chceš                        # svými slovy
2. Přečti si Claudův plán                 # když něco nesedí, řekni co
3. Řekni "pokračuj"                       # Claude napíše kód
4. Podívej se co se změnilo               # projdi editace, zeptej se na nejasnosti
5. Řekni Claudovi ať uloží práci          # "commitni to"
```

To je vše. Až se budeš cítit jistěji, můžeš přidat `/code-review` po kroku 3
a `/verify` před krokem 5 — ale ze začátku se tím netrap.

### Commituj často, v malých kouscích

Po každé funkční feature commitni. Když nashromáždíš celý den práce do jednoho
commitu a na konci se něco rozbije, nemůžeš vrátit jen část — ztratíš všechno.
Pět malých commitů jde zachránit; jeden velký ne.

### Sleduj co Claude mění během práce

Claude ukazuje každou editaci souboru. Projdi je. Když něco vypadá špatně
(nový soubor o který jsi nežádal, neznámá dependence, řádka kterou nechápeš),
zastav ho pomocí `Esc` a zeptej se. Neukládej problémy až do `/code-review` —
chytit je dřív je levnější.

### Jedna věc najednou

Odolávej "když už jsi u toho, taky udělej X." Každá session by měla být jedna
feature nebo jeden bug. Když míchás úkoly, diff je nepřehledný a nepoznáš,
která změna rozbila co.

### Kdy zasáhnout

Přestaň nechávat Clauda pracovat a zasáhni sám když:
- Zkusil stejnou opravu dvakrát nebo třikrát
- Plán je mnohem větší než jsi čekal (5+ souborů když jsi chtěl 1)
- Vytváří nové soubory o které jsi nežádal
- Chybové zprávě nerozumíš — přečti ji, vyhledej si ji, vrať se

### Když něčemu nerozumíš

Zeptej se. "Vysvětli co tato funkce dělá jednodušě" je platný prompt.
Neakceptuj kód, který neumíš přečíst — dříve nebo později se rozbije a
neopravíš ho.

---

## Tři věci, které tahají tvoje peníze

1. **Nechávat Clauda mlátit do stejné chyby.** Když selže dvakrát, zastav se a přečti
   chybu sám. Řekni Claudovi co konkrétně vidíš. Neříkej "zkus znovu."

2. **Táhnout starý kontext mezi nesouvisejícími úkoly.** Když měníš téma, spusť
   `/compact`. Jinak každý prompt znovu účtuje celou předchozí konverzaci.

3. **Vágní prompty.** "Udělej to líp" stojí stejně k odeslání jako konkrétní prompt,
   ale vyplodí špatný kód, jehož oprava stojí 10x víc.
