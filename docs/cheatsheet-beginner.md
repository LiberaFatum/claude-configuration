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

### 1. Building something

| Bad | Better |
|-----|--------|
| `make a login page` | `Add a login page to @src/pages/. Use the form pattern from @src/pages/signup.tsx. Submit to /api/auth/login and redirect to /dashboard on success.` |

Why: Bad version = Claude invents a new pattern. Better version = Claude reuses
your existing code and you get something consistent.

### 2. Fixing a bug

| Bad | Better |
|-----|--------|
| `fix the error` | `In @server.py the /upload endpoint returns 500 when the file is over 10MB. Should return 413 with a clear error message instead.` |

Why: Bad version = Claude runs the code blindly looking for any error. Better
version = Claude knows exactly which file, which symptom, which behavior you want.

### 3. Adding a feature

| Bad | Better |
|-----|--------|
| `add search` | `Add a search box to @src/components/ProductList.tsx that filters products by name as the user types. Case-insensitive, debounce 300ms.` |

Why: "add search" could mean ten different things. The good prompt is unambiguous.

### 4. Asking a question

| Bad | Better |
|-----|--------|
| `why doesnt this work` | `In @src/api/auth.py line 42, why does verify_token() return None for valid tokens? Test that fails: @tests/test_auth.py::test_valid_token` |

Why: Including the file paths means Claude reads the actual code instead of
inventing a possible explanation.

### 5. Refactoring

| Bad | Better |
|-----|--------|
| `clean up this code` | `In @src/utils/format.ts, the formatCurrency function is duplicated in three places. Extract it to one place and update the callers.` |

Why: "clean up" is subjective. The good prompt has one specific outcome you can verify.

---

## Best workflow practices

### A typical task, start to finish

```
1. /plan "what you want"           # Claude shows a plan
2. read the plan                   # if wrong, say what's wrong; don't approve blindly
3. "go ahead"                      # Claude writes the code
4. /code-review                    # catches bugs before they land
5. /verify                         # runs build, tests, lint
6. git commit                      # small, descriptive
7. /compact                        # before starting the next thing
```

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

# Cheatsheet pro zacatecniky (CZ)

Pro lidi novych v programovani nebo v Claude Code. Precti si jednou, vrat se kdyz potrebujes.

---

## Prvni pouziti v projektu

Napis jeden prikaz:

```
/switch-tier beginner
```

Vytvori `CLAUDE.md` a zapne snadny rezim (jednoduchy jazyk, pta se pred akci).
To je cele nastaveni.

---

## Ctyri veci o chatu, co musis vedet

| Symbol | Co dela | Priklad |
|--------|---------|---------|
| `@` | Odkaz na soubor nebo slozku | `Precti @src/auth.py a vysvetli co dela` |
| `!` | Spusti shell prikaz | `! ls` nebo `! npm install` |
| `/` | Spusti Claude prikaz | `/plan`, `/code-review` |
| `Esc` | Prerusi Clauda behem odpovedi | Stiskni kdyz Claude jde spatne |

Pouzivej `@` neustale. Je to nejvetsi rozdil mezi vague prompty a presnymi —
Claude precte presne ten soubor, na ktery ukazes, misto aby hadal.

---

## Pet prikazu, ktere se vyplati

| Prikaz | Kdy ho pouzit |
|--------|---------------|
| `/plan "co chces udelat"` | Pred kazdym vetsim ukolem. Claude ukaze plan, ty schvalis. |
| `/code-review` | Po napsani kodu. Odhali bugy pred commitnutim. |
| `/verify` | Pred commitem. Spusti build + testy + lint + typecheck. |
| `/compact` | Mezi ruznymi ukoly. Uvolni pamet, setri penize. |
| `/switch-tier <uroven>` | Zmena rezimu (beginner / intermediate / advanced). |

Vse ostatni preskakuj dokud to opravdu nepotrebujes.

---

## Priklady kvality promptu

Tvuj prompt je nejvetsi faktor pro cenu i kvalitu vysledku.

### 1. Stavet neco

| Spatne | Lepe |
|--------|------|
| `udelej prihlasovaci stranku` | `Pridej prihlasovaci stranku do @src/pages/. Pouzij vzor z @src/pages/signup.tsx. Odesilej na /api/auth/login a po uspechu presmeruj na /dashboard.` |

Proc: Spatna verze = Claude vymysli novy vzor. Lepsi verze = Claude pouzije
existujici kod a vysledek je konzistentni.

### 2. Opravit bug

| Spatne | Lepe |
|--------|------|
| `oprav tu chybu` | `V @server.py endpoint /upload vraci 500 kdyz je soubor vetsi nez 10MB. Mel by vracet 413 s jasnou chybovou zpravou.` |

Proc: Spatna verze = Claude bezi kod naslepo a hleda jakoukoli chybu. Lepsi
verze = Claude vi presne ktery soubor, ktery symptom, jake chovani chces.

### 3. Pridat feature

| Spatne | Lepe |
|--------|------|
| `pridej vyhledavani` | `Pridej vyhledavaci pole do @src/components/ProductList.tsx ktere filtruje produkty podle nazvu pri psani. Case-insensitive, debounce 300ms.` |

Proc: "Pridej vyhledavani" muze znamenat deset veci. Dobry prompt je jednoznacny.

### 4. Polozit otazku

| Spatne | Lepe |
|--------|------|
| `proc to nefunguje` | `V @src/api/auth.py na radku 42, proc verify_token() vraci None pro platne tokeny? Test ktery selhava: @tests/test_auth.py::test_valid_token` |

Proc: Cesty k souborum znamenaji ze Claude precte skutecny kod misto
vymysleni mozneho vysvetleni.

### 5. Refaktoring

| Spatne | Lepe |
|--------|------|
| `vycisti tenhle kod` | `V @src/utils/format.ts je funkce formatCurrency duplikovana na trech mistech. Extrahuj ji na jedno misto a uprav volajici.` |

Proc: "Vycisti" je subjektivni. Dobry prompt ma jeden konkretni vysledek, ktery jde overit.

---

## Nejlepsi workflow praktiky

### Typicky ukol od zacatku do konce

```
1. /plan "co chces"               # Claude ukaze plan
2. precti plan                    # kdyz je spatny, rekni co; neschvaluj naslepo
3. "pokracuj"                     # Claude napise kod
4. /code-review                   # odhali bugy pred ulozenim
5. /verify                        # spusti build, testy, lint
6. git commit                     # maly, popisny
7. /compact                       # pred dalsi vec
```

### Commituj casto, v malych kouscich

Po kazde funkcni feature commitni. Kdyz nashromazdi cely den prace do jednoho
commitu a na konci se neco rozbije, nemuzes vratit jen cast — ztratis vsechno.
Pet malych commitu jde zachranit; jeden velky ne.

### Sleduj co Claude meni behem prace

Claude ukazuje kazdou editaci souboru. Projdi je. Kdyz neco vypada spatne
(novy soubor o ktery jsi nezadal, neznama dependence, radka kterou nechapes),
zastav ho pomoci `Esc` a zeptej se. Neukladej problemy az do `/code-review` —
chytit je drive je levnejsi.

### Jedna vec najednou

Odolavej "kdyz uz jsi u toho, taky udelej X." Kazda session by mela byt jedna
feature nebo jeden bug. Kdyz michas ukoly, diff je neprehledny a nepoznas,
ktera zmena rozbila co.

### Kdy zasahnout

Prestan nechat Clauda pracovat a zasahnete sami kdyz:
- Zkusil stejnou opravu dvakrat nebo trikrat
- Plan je mnohem vetsi nez jsi cekal (5+ souboru kdyz jsi chtel 1)
- Vytvari nove soubory o ktere jsi nezadal
- Chybove zprave nerozumis — precti ji, najdi si ji, vrat se

### Kdyz necemu nerozumis

Zeptej se. "Vysvetli co tato funkce dela jednoduse" je platny prompt.
Neakceptuj kod, ktery neumis precist — drive nebo pozdeji se rozbije a
neopravis ho.

---

## Tri veci, ktere tahaji tvoje penize

1. **Necht Clauda mlatit do stejne chyby.** Kdyz selze dvakrat, zastav se a precti
   chybu sam. Rekni Claudovi co konkretne vidis. Nerikej "zkus znovu."

2. **Tahat stary kontext mezi nesouvisejicimi ukoly.** Kdyz menis tema, spust
   `/compact`. Jinak kazdy prompt znovu uctuje celou predchozi konverzaci.

3. **Vague prompty.** "Udelej to lip" stoji stejne k odeslani jako konkretni prompt,
   ale vyplodi spatny kod, jehoz oprava stoji 10x vic.
