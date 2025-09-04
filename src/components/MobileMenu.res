
type action = Toggle | Close 

type state = {isOpen: bool}

let reducer = (state, action) => {
  switch (state.isOpen,action) {
  | (false, Toggle) => {isOpen: true}
  | (true, Toggle) => {isOpen: false}
  | (_,Close) => {isOpen: false}
  }
}

let initialState = {isOpen: false}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  let lines = "block bg-[#5A5A5A] w-full h-[2px] rounded-xs"
  let menu = "cursor-pointer absolute top-0 right-0 w-[24px] h-[13.5px] flex flex-col justify-between translate-y-[200%] -translate-x-[100%]"
  let link = "font-serif cursor-pointer p-2"
  let links = [
      ("#/home", "Home"),
      ("#/investment", "Investment"),
      ("#/galleries", "Galleries"),
      ("#/about", "About Photographer"),
    ]

  React.array([
    <button key="hamburger" onClick={_ => dispatch(Toggle)} className={menu}>
      <span className={lines} />
      <span className={lines} />
      <span className={lines} />
    </button>,
    switch state.isOpen {
    | false => React.null
    | true => <div
        key="menu"
        className="pb-4 shadow-md bg-white z-10 absolute top-[calc(var(--mobile-nav-height)-1px)] right-0 flex flex-col justify-center items-center w-full">
        {links->Array.map(((href, text)) =>
            <a key=href className=link href=href onClick={(_) => dispatch(Close)}> {React.string(text)} </a>
          )->React.array
        }
      </div>
    }
  ])
}
