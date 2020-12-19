# Concentration

## 📱 실행화면

**portrait mode**
<p float="left">
<img width="250" src="https://user-images.githubusercontent.com/60229909/102688719-e3f63800-423b-11eb-9bd3-e1c97944aed6.png">
<img width="250" src ="https://user-images.githubusercontent.com/60229909/102688759-16a03080-423c-11eb-821c-068c87fbfedb.png">

**landscape mode**
</p>
<p float="left">
<img width="450" src="https://user-images.githubusercontent.com/60229909/102688761-1869f400-423c-11eb-84c3-097387953ff9.png">
<img width="450" src="https://user-images.githubusercontent.com/60229909/102688762-19028a80-423c-11eb-8000-ff984523002a.png">
</p>

## 📦 MVC 설계

### Model
1. **Concentration** 
    - Property 
        - cards
    - Function    
        - chooseCard 

    Skeleton Code
    ```swift
    class Concentration{
        var cards: Array<Card>

        func chooseCard(at index: Int)
    }
    ```
2. **Card** 
    - Property
        - isFaceUP : Bool
        - isMAtched : Bool
        - identifier : Int

    Skeleton Code
    ```swift
    struct Card {
        var isFaceUP = false
        var isMatched = false
        var identifier: Int
    }
    ```
### Controller
- ViewController
    - touchCard
    - updateViewFromModel

### View
- UIButton
- UILabel

## ⚙️ 상세설계

1. Concentration

    | Property | Action |
    |------|---------|
    | cards | 카드 뭉치 |
    | indexOfOneAndOnlyFaceUpCard | 몇 장의 카드가 뒤집어져 있는지 확인하는 변수 |

    | Function | Action |
    |------|---------|
    | chooseCard | 뒤집혀진 카드들의 상태를 파악하는 함수 |

2. ViewController

    | Property | Action |
    |------|---------|
    | game | model을 생성하여 저장 |
    | numberOfParisOfCardds | 카드쌍의 갯수 저정 |
    | flipCount | 카드를 뒤집은 횟수 저장 |
    | cardButons | UIButton으로 이뤄진 배열 |
    | emojiChoices | 이모티콘의 종류 |
    | emoji | 실제 뒷면에 보여질 이모티콘을 가지고 있는 딕셔너리 |


    | Function | Action |
    |------|---------|
    | touchCard | 카드를 터치하였을때 실행되는 함수 |
    | updateViewFromModel | 카드의 UI를 설정하는 함수 |
    | emoji | 이모지 아이콘을 반환하는 함수 |
    | | emoji 딕셔너리에 저장되어있다면 저장된 value값을 return 하지만 저장되어있지 않은 경우 새로운 이모티콘을 할당하여 return 한다. |
