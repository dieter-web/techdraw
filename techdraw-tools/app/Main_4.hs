import qualified Data.Text as T
import qualified Data.Text.IO as T1
import TechDraw.Core.Style
import TechDraw.Core.Types
import TechDraw.SVG.Render (renderPath, renderShape)

main :: IO ()
main = do
  let t :: T.Text
      t = T.pack "black"

  let shape = SLine (Point 10 10) (Point 20 20)
      stroke = Stroke t 1
      fill = Just FillNone
      rend = renderShape shape stroke fill

  let path = renderPath [M (Point 10 10)]

  T1.putStrLn rend
  T1.putStrLn path
